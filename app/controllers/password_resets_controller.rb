class PasswordResetsController < ApplicationController

  def new
  end

  def create
  	user = User.find_by_email(params[:reset][:email])
    if user
      user.send_password_reset if user
      redirect_to root_url, notice: t('controllers.password_reset.create')
    else
      redirect_to new_password_reset_path, alert: t('controllers.password_reset.error_message')
    end
  end

  def edit
  	@user = User.find_by_password_reset_token!(params[:id])
  end

  def update
  	@user = User.find_by_password_reset_token!(params[:id])
	  if @user.password_reset_sent_at < RESET_PASSWORD_TIME_LIMIT
	    redirect_to new_password_reset_path, :alert => t('controllers.password_reset.update_error')
	  elsif @user.update_attributes(params[:user])
	    redirect_to root_url, :notice => t('controllers.password_reset.update_password')
	  else
	    render :edit
	  end
  end
  
end
