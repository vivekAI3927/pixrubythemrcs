class GocardlessController < ApplicationController
  skip_before_action :authenticate_user!, only: [:stripe_events,:success, :canceled, :confirm], raise: false
  skip_before_action :is_membership_subscribed?
  skip_before_action :verify_authenticity_token, only: [:stripe_events,:success, :canceled, :confirm], raise: false

  # ENTRY POINT FOR STARTING A PAYMENT
  # users end up here after completing basic signup
  # /users/:id/start_payment
  # start_payment_user_path(user_object or id)
  def index
    @user = User.find(params[:id])
    if session[:renew]
      @memberships = Membership.on_renewal.order(:price).limit(1)
    elsif @user.subscribed_on && @user.membership_expired?
      return redirect_to new_user_membership_path(@user), notice: t('controllers.sessions.renew_membership')
    else
      @memberships = Membership.order(:price)
    end 
    @cost = @user.membership.price
    # note stripe requires the cost in pence
    @stripe_cost = @cost * 100

  end

  def create; end

  def success
    begin
      require 'stripe'
      Stripe.api_key = ENV["STRIPE_SECRET_KEY"]

      @user = User.find(params[:payment][:user_id])
      user_stripe_id = @user.stripe_id
      @user_membership = Membership.find_by(params[@user.membership_id])
      Stripe::Charge.create({
        amount: @user_membership.price,
        currency: 'gbp',
        customer: "#{user_stripe_id}",
        description: "My First Test Charge is #{@user_membership.price} for #{@user_membership.length} months (created for API docs)",
      })
      @user.update(subscribed_expired_at: month_calc( @user_membership.length), subscribed_on: DateTime.now)
      Rails.logger.info " =============Payment Webhook Called =============="
      Rails.logger.info params
      Rails.logger.debug params.inspect
      # GoCardless.confirm_resource params
      # @user = User.find(params[:state])
      # @user.start_subscription
      # render "gocardless/success"
    rescue Exception => e
      @error = e
      render :text => "Could not confirm new subscription. Details: #{e}"
    end
  end

  def canceled
    begin
      render "gocardless/canceled"
    rescue Exception => e
      @error = e
      render :text => "Could not confirm new subscription. Details: #{e}"
    end
  end

  def stripe_events
    # Webhhok for stripe payments
    begin
      require 'stripe'
      Stripe.api_key = ENV["STRIPE_SECRET_KEY"]

      @user = User.find(params[:id])
      @user_membership = Membership.find_by(params[@user.membership_id])
      if @user.stripe_id.nil?
        user_stripe_id = Stripe::Customer.create({
          name: @user.name,
          email: @user.email,
          currency: @user.email,
          description: "Membership plan £#{@user_membership.price} for #{@user_membership.length} months."
        })
        @user.update(stripe_id: user_stripe_id.id)
      end
      # Rails.logger.info " =============Payment Webhook Called =============="
      # Rails.logger.info params
      # verify_webhook_signature
      # render body: nil
    rescue Exception => e
      Rails.logger.info  "Could not confirm new subscription. Details: #{e}"
      # render body: nil
    end

  end

  def apply_coupon
    @user  = User.find(params[:id])
    coupon = Coupon.find_by_name(params[:coupon])
    base_cost = @user.membership.price
    if coupon
      coupon.increment_coupon_uses
      @user.apply_coupon(coupon.name)
      discount_multiplier = 1 - ((coupon.discount.to_f)/100)
      @cost = base_cost * discount_multiplier
      session[:cost] = @cost
      flash.now.notice = t('controllers.gocardless.coupon_applied')
      render "index"
    else
      @cost = base_cost
      flash.now.alert = t('controllers.gocardless.coupon_not_found')
      render "index"
    end
  end

  def membership_plan_country_wise
    @memberships = Membership.order(price: :asc)
    @user = User.find(current_user.id)
    if params[:latitude].present? && params[:longitude].present?
      results = Geocoder.search([params[:latitude], params[:longitude]])
      country_code = results.first.country_code.upcase
                       if Membership.exists?({location: [country_code]})        
        @country_code = country_code
      else
        results = Geocoder.search("United Kingdom")
        @country_code = results.first.country_code.upcase
      end
    else
      results = Geocoder.search("United Kingdom")
      @country_code = results.first.country_code.upcase
    end
    respond_to do |format|
      format.js
    end

  end

  # def change_membership_plan_after_select
  #   @user = current_user
  #   @user.update(membership_id: params[:membership_id])
  #   redirect_to gocardless_index_path(@user.id)
  # end

  private

  def verify_webhook_signature
    Rails.logger.info "Verify Stripe webhook"
    endpoint_secret = ENV['STRIPE_WEBHOOK_SECRET']
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    event = nil

    begin
      event = Stripe::Webhook.construct_event(
        payload, sig_header, endpoint_secret
      )
      Rails.logger.info "Event: #{event}"
    rescue JSON::ParserError => e
      # Invalid payload
      Rails.logger.info "Error: #{e}"
      return
    rescue Stripe::SignatureVerificationError => e
      # Invalid signature
      Rails.logger.info "Error: #{e}"
      return
    end

    # Handle the event
    case event.type
      when 'payment_intent.succeeded'
        payment_intent = event.data.object # contains a Stripe::PaymentIntent
        Rails.logger.info 'PaymentIntent was successful!'
        save_payment
      when 'payment_method.attached'
        payment_method = event.data.object # contains a Stripe::PaymentMethod
         Rails.logger.info 'PaymentMethod was attached to a Customer!'
      # ... handle other event types
    else
        # Unexpected event type
        save_payment
        Rails.logger.info "Error: Unexpected event type"
        return
    end
  end

  def save_payment
    @user = User.where(id: params['data']['object']['client_reference_id']).first
    @user.start_subscription if @user
    session[:renew] = nil if @user
    UserMemberships.create(response: params['data'],  user_id: @user.try(:id) )
    @user.create_payment("Stripe", params)
    UserMailer.paid_message(@user).deliver
  end
end
