# frozen_string_literal: true

class Admin::BaseController < ApplicationController
  before_action :authenticate_admin!
  layout 'admin'

  private

  def set_admin_access
    if current_admin.super_admin == true
      return true
    else
      if current_admin.admin_access.present? && current_admin.admin_access.allow_model_name.present?
        current_admin_access_model = current_admin.admin_access.allow_model_name  
        access_allow = (current_admin_access_model.include? "Dashboard") || (current_admin_access_model.include? controller_name.classify)
        if access_allow == false
          redirect_to "/admin", notice: t('controllers.admin.admin_allow_access.message')
        end
      else
        redirect_to "/admin", notice: t('controllers.admin.admin_allow_access.message')
      end
    end    
  end

  def set_admin_parta_access
    if current_admin.super_admin == true
      return true
    else
      if current_admin.admin_access.present? && current_admin.admin_access.allow_model_name.present?
        current_admin_access_model = current_admin.admin_access.allow_model_name
        @current_controller = controller_path.classify.split('::')[1] + controller_path.classify.split('::')[2]
        access_allow = current_admin_access_model.include? @current_controller
        if access_allow == false
          redirect_to "/admin", notice: t('controllers.admin.admin_allow_access.message')
        end
      else
        redirect_to "/admin", notice: t('controllers.admin.admin_allow_access.message')
      end  
    end  
  end

end
