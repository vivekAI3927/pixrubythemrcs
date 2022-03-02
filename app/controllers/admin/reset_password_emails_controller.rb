class Admin::ResetPasswordEmailsController < Admin::BaseController

  helper_method :sort_column, :sort_direction
 
  def index
    if params[:sort].present?
      @reset_password_emails = ResetPasswordEmail.all.paginate(:page => params[:page], :per_page => 100).order(sort_column + " " + sort_direction)
    else  
      @reset_password_emails = ResetPasswordEmail.all.paginate(:page => params[:page], :per_page => 10)
    end  
  end

  def new
    @reset_password_email = ResetPasswordEmail.new
  end

  def show
    @reset_password_email = ResetPasswordEmail.find(params[:id])
  end

  def edit
    @reset_password_email = ResetPasswordEmail.find(params[:id])
  end  

  def create
    @reset_password_email = ResetPasswordEmail.new(reset_password_email)
    if @reset_password_email.save
      redirect_to "/admin/reset_password_emails", notice: t('controllers.admin.reset_password_emails.create')  
    else
      flash[:error] = t('controllers.admin.errors.message')
      render "new"
    end
  end

  def update
    @reset_password_email = ResetPasswordEmail.find(params[:id])
    if @reset_password_email.update_attributes(reset_password_email)
      redirect_to "/admin/reset_password_emails", notice: t('controllers.admin.reset_password_emails.update')
    else
      flash[:alert] = t('controllers.admin.errors.message')
      render "edit"
    end
  end


  private

  def reset_password_email
    params.require(:reset_password_email).permit(:title, :description)
  end

   def sort_column
    ResetPasswordEmail.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
