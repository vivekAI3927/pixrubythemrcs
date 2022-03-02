class Admin::AdminAccessesController < Admin::BaseController

  def create
    @all_selected_models = params[:admin][:allow_model_name].reject {|select_model_name| select_model_name == "0"}
    @admin_access = AdminAccess.new(admin_access_params)
    @admin_access.allow_access = true
    @admin_access.allow_model_name = @all_selected_models
    if @admin_access.save
      redirect_back fallback_location: root_path
    end
  end

  def update
    @all_selected_models = params[:admin][:allow_model_name]
    @admin_access = Admin.find_by(id: params[:admin_id]).admin_access
    @admin_access.allow_model_name = @all_selected_models
    if @admin_access.update(admin_access_params)
      redirect_back fallback_location: root_path
    end
  end
  
  private

  def admin_access_params
    params.require(:admin).permit(:id, :admin_id, :allow_access, allow_model_name: [])
  end
end
