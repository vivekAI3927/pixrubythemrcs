class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :is_membership_subscribed?

  def after_sign_up_path_for(resource)
    redirect_to start_payment_user_path(resource), notice: t('controllers.application.register_message')
  end
  
  def after_sign_in_path_for(resource)
    # redirect on desired dashboard as per user role
    case resource
    when current_user
      categories_path
    when current_admin
      admin_root_path
		when current_parta_user
			parta_registration_complete_path(resource)
      # '/parta'
    end
  end

  # it will call before every action on this controller
    def is_membership_subscribed?
      # check if user subscribed membership
      # if not admin then redirect to where ever you want
      if current_user 
        redirect_to start_payment_user_path(current_user) unless (current_user.valid_subscription?)
      end
    end

  def is_admin_editor?
    true
  end

  def is_trial_false
    if params[:station_id].present?
      @station = Station.friendly.find(params[:station_id])
    else
      @station = Station.friendly.find(params[:id])
    end
     # redirect if not an trial station
     if !current_user && @station.trial == false
      redirect_to root_path, notice: t('controllers.application.trial_false')
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:country,:referred_by, :target_exam_date, :membership_id, :target_speciality_id])
  end
end
