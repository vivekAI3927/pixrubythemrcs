class UsersController < ApplicationController
  skip_before_action :is_membership_subscribed?, only: [:update]

	def new
		@user = User.new
	end

	def create
    clear_session_cost

		@user = User.new(params[:user])
		if @user.save
      # UserMailer.registration_message(@user).deliver
      UserMailer.delay.registration_message(@user)
			redirect_to start_payment_user_path(@user), notice: t('controllers.users.welcome_message')
		else
			render "new"
		end
	end

  # used when a user membership has expired and they are updating to a new one
  def update
    clear_session_cost

    @user = User.find(params[:id])
    @user.membership_id = params[:user][:membership_id]
    
    if @user.save
      if @user.membership_expired?
        session[:renew] = true
      end
      redirect_to start_payment_user_path(@user, renew: true)
    else
      redirect_to new_user_membership_path(@user), notice: t('controllers.users.pending')
    end
  end

  def recommend
  end

  # User can cancel membership
  def cancel_membership
    current_user.update(subscribed_expired_at: DateTime.now)
    redirect_to start_payment_user_path(current_user)
  end

  private

  def clear_session_cost
    if session[:cost]
      session.delete(:cost)
    end
  end

end
