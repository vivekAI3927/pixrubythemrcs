class PaypalPaymentNotificationsController < ApplicationController
  
  skip_before_action :is_membership_subscribed?
  protect_from_forgery except: :create
  skip_before_action :verify_authenticity_token, raise: false

  # handles IPN from Paypal and starts a subscription.
  def create
    begin
      Rails.logger.info " =============Payment Webhook Called =============="
      Rails.logger.info params
      Rails.logger.debug params.inspect
      @user = User.find(params[:purchase_units]['0']['reference_id'])
      @user.create_payment("Paypal", params)
      if params[:status] == COMPLETED.upcase
        @user.start_subscription
        session[:renew] = nil
        UserMailer.paid_message(@user).deliver
      end
      render body: nil

    rescue Exception => e
      Rails.logger.info "Could not confirm new subscription. Details: #{e}"
      render body: nil
    end
    
  end

  def index
    render "gocardless/success"
  end

end
