class Admin::Parta::SettingsController < Admin::BaseController
  before_action :set_admin_parta_access

  def index
   @parta_home_pages = Parta::Setting.all.paginate(:page => params[:page], :per_page => 10)
  end

  def new
    @parta_home_page = Parta::Setting.new
  end

  def destroy
    @parta_home_page = Parta::Setting.find_by(id: params[:id])
    @parta_home_page.destroy
    respond_to do |format|
      format.html { redirect_to admin_parta_settings_path, notice: t('controllers.admin.parta_settings.destroy') }
      format.json { head :no_content }
    end
  end

  def show
    @parta_home_page = Parta::Setting.find_by(id: params[:id])
  end

  def edit
    @parta_home_page = Parta::Setting.find_by(id: params[:id])
  end

  def create
    @parta_home_page = Parta::Setting.new(parta_home_page_params)
    if @parta_home_page.save
      redirect_to "/admin/parta/settings", notice: t('controllers.admin.parta_settings.create')  
    else
      render "new"
    end
  end

  def update
     @parta_home_page = Parta::Setting.find_by(id: params[:id])
    if @parta_home_page.update(parta_home_page_params)
      redirect_to "/admin/parta/settings", notice: t('controllers.admin.parta_settings.update')
    else
      render "edit"
    end
  end

  private

  def parta_home_page_params
    params.require(:parta_setting).permit(:title, :banner_text)
  end

end
