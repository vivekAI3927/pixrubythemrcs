class Admin::AboutsController < Admin::BaseController
  before_action :set_admin_access
 
  def index
   # @prices = Price.all
   @about_us = About.all.paginate(:page => params[:page], :per_page => 10)
   @about_us_image = AboutUsImage.new
  end

  def show
    @about_us = About.find_by(id: params[:id])
  end

  def edit
    @about_us = About.find_by(id: params[:id])
  end

  def update
     @about_us = About.find_by(id: params[:id])
    if @about_us.update(about_params)
      redirect_to "/admin/abouts/#{@about_us.id}", notice: t('controllers.admin.abouts.update')  
    else
      flash[:error] = t('controllers.admin.errors.message')
      redirect_to "/admin/abouts/#{@about_us.id}/edit"
    end
  end

  private

  def about_params
    params.require(:about).permit(:description, :image)
  end

end
