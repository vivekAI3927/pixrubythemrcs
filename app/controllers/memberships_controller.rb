class MembershipsController < ApplicationController
  # before_action :authenticate_user!
  skip_before_action :is_membership_subscribed?

  def new
    @membership = Membership.new
    @user = User.find(params[:user_id])
  end
  
end
