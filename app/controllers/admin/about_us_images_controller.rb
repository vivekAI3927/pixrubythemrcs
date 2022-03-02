class Admin::AboutUsImagesController < Admin::BaseController
  before_action :set_admin_access
  def index
   # @prices = Price.all
   @about_us_images = AboutUsImage.all.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @about_us_image = AboutUsImage.find_by(id: params[:id])
  end

  def edit
    @about_us_image = AboutUsImage.find_by(id: params[:id])
  end

  def new
    about_us_image = AboutUsImage.new
  end

  def create
    @about_us_image = AboutUsImage.new(about_us_image_params)
    if @about_us_image.save
      redirect_to admin_abouts_path, notice: t('controllers.admin.about_us_images.create')
    else
      render "new"
    end
  end

  def destroy
    @about_us_image = AboutUsImage.find_by(id: params[:id])
    @about_us_image.destroy
    respond_to do |format|
      format.html { redirect_to admin_abouts_path, notice: t('controllers.admin.about_us_images.destroy') }
      format.json { head :no_content }
    end
  end  

  def update
     @about_us_image = AboutUsImage.find_by(id: params[:id])
    if @about_us_image.update(about_us_image_params)
      redirect_to "/admin/abouts", notice: t('controllers.admin.about_us_images.update')  
    else
      flash[:error] = t('controllers.admin.errors.message')
      redirect_to "/admin/abouts/#{@about_us_image.id}/edit"
    end
  end

  private

  def set_admin_access
    if current_admin.super_admin == true
      return true
    else  
      if current_admin.admin_access.present? && current_admin.admin_access.allow_model_name.present?
        current_admin_access_model = current_admin.admin_access.allow_model_name  
        access_allow = current_admin_access_model.include? "AboutUsImage"
        if access_allow == false
          redirect_to "/admin", notice: t('controllers.admin.admin_allow_access.message')
        end
      else
        redirect_to "/admin", notice: t('controllers.admin.admin_allow_access.message')
      end
    end    
  end

  def about_us_image_params
    params.require(:about_us_image).permit(:image)
  end

end
