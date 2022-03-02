class Admin::PartaInfosController < Admin::BaseController
  before_action :set_admin_access

  def index
   @parta_info = PartaInfo.all.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @parta_info = PartaInfo.find_by(id: params[:id])
  end

  def edit
    @parta_info = PartaInfo.find_by(id: params[:id])
  end

  def update
     @parta_info = PartaInfo.find_by(id: params[:id])
    if @parta_info.update(parta_info_params)
      redirect_to "/admin/parta_infos/#{@parta_info.id}", notice: t('controllers.admin.parta_infos.update')  
    else
      flash[:error] = "One or more required fields are missing"
      redirect_to "/admin/parta_infos/#{@parta_info.id}/edit"
    end
  end

  private

  def parta_info_params
    params.require(:parta_info).permit(:heading_info, :body_info)
  end

end
