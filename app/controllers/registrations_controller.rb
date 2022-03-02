# app/controllers/registrations_controller.rb
class RegistrationsController < Devise::RegistrationsController
	skip_before_action :is_membership_subscribed?

  def new
    super
  end

  def create
    super
  end

  def update
    super
  end
end 