class Admin::EmailFormatsController < Admin::BaseController
  before_action :set_admin_access
  
  def index
   @email_formats = EmailFormat.all
  end

  def new
    @email_format = EmailFormat.new
  end

  def show
    @email_format = EmailFormat.find(params[:id])
  end

  def edit
    @email_format = EmailFormat.find(params[:id])
  end  

  def create
    @email_format = EmailFormat.new(privacy_params)
    if @email_format.save
      redirect_to "/admin/email_formats", notice: t('controllers.admin.email_formats.create')  
    else
      flash[:error] = t('controllers.admin.errors.message')
      render "new"
    end
  end

  def update
    @email_format = EmailFormat.find(params[:id])
    if @email_format.update_attributes(privacy_params)
      redirect_to "/admin/email_formats", notice: t('controllers.admin.email_formats.update')
    else
      flash[:alert] = t('controllers.admin.errors.message')
      render "edit"
    end
  end

  private

  def privacy_params
    params.require(:email_format).permit(:exam_reminder, :not_join_message, :paid_message)
  end

end
