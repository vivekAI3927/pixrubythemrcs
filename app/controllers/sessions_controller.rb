class SessionsController < Devise::SessionsController
  skip_before_action :is_membership_subscribed?
  def new
    super
  end

  def create
    super
    # # self.resource = warden.authenticate!(auth_options)
    # # set_flash_message(:notice, :signed_in) if is_navigational_format?
    # user = User.find_by_email(params[:user][:email])
    # token = SecureRandom.urlsafe_base64
    # if user && user.valid_password?(params[:user][:password])
    #   user.update_attributes(authentication_token: token)
    #   session[:authentication_token] = token
    #   sign_in(:user, user)
    #   flash[:success] = t('controllers.sessions.successfully')
    #   if user.membership
    #     # validate subscription
    #     if user.valid_subscription?
    #         return redirect_to "/categories"
    #     else
    #       return redirect_to start_payment_user_path(user), notice: t('controllers.application.register_message')

    #     end
    #   end
    # else
    #   flash[:alert] = t('controllers.sessions.invalid')
    #   return redirect_to "/users/sign_in"
    # end
    # if !session[:return_to].blank?    
    #   redirect_to session[:return_to]
    #   session[:return_to] = nil
    # else
    #   # respond_with resource, :location => after_sign_in_path_for(resource)
    #   redirect_to "/"
    # end
  end  

  def destroy
    # destroy user session
    current_user.invalidate_all_sessions!
    super
  end



end
