class StripePaymentsController < ApplicationController
  
  require 'stripe'
  Stripe.api_key = ENV["STRIPE_SECRET_KEY"]

  def create
    begin
      @user = User.find(params[:id])
      @cost = session[:cost] ||= @user.membership.price
      @stripe_cost = @cost * 100

      # token return by Stripe checkout process as part of data params
      token = params[:stripeToken]

      # make the charge on stripe
      charge = Stripe::Charge.create(
        amount: @stripe_cost.to_i,
        currency: CURRENCY.downcase,
        description: "PassTheMRCS Membership",
        source: token
      )

      # clear out any stored cost from the session i.e. applied from a coupon
      clear_session_cost

      # start the membership
      @user.start_subscription
      render "gocardless/success"

    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to start_payment_user_path(@user)
    end
  end

  private

  def clear_session_cost
    session[:cost] = nil if session[:cost]
  end

end
