class Admin::HomeLogoBannersController < Admin::BaseController
  before_action :set_admin_access
  helper_method :sort_column, :sort_direction
 
  def index
   @home_logo_banners =  HomeLogoBanner.all.paginate(:page => params[:page], :per_page => 10)
  end

  def new
    @home_logo_banner = HomeLogoBanner.new
  end

  def destroy
    @home_logo_banner = HomeLogoBanner.find_by(id: params[:id])
    @home_logo_banner.destroy
    respond_to do |format|
      format.html { redirect_to admin_home_logo_banners_path, notice: t('controllers.admin.home_logo_banners.destroy') }
      format.json { head :no_content }
    end
  end

  def show
    @home_logo_banner = HomeLogoBanner.find_by(id: params[:id])
  end

  def edit
    @home_logo_banner = HomeLogoBanner.find_by(id: params[:id])
  end

  def create
    @home_logo_banner = HomeLogoBanner.new(home_logo_banner_params)
    if @home_logo_banner.save
      redirect_to "/admin/home_logo_banners", notice: t('controllers.admin.home_logo_banners.create')  
    else
      render "new"
    end
  end
  
  def update
     @home_logo_banner = HomeLogoBanner.find_by(id: params[:id])
    if @home_logo_banner.update(home_logo_banner_params)
      redirect_to "/admin/home_logo_banners", notice: t('controllers.admin.home_logo_banners.update')
    else
      render "edit"
    end
  end

  def download_pdf
    @home_logo_banner = HomeLogoBanner.find_by(id: params[:home_logo_banner_id])
    html = render_to_string(:action => 'download_pdf', :layout => false)
    pdf = PDFKit.new(html)
    send_data(pdf.to_pdf)
  end  

  private

  def home_logo_banner_params
    params.require(:home_logo_banner).permit(:first_title, :second_title, :description, :logo_file_name, :banner_file_name)
  end

  def sort_column
    HomeLogoBanner.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
