class Admin::UserInterestedCochingEmailsController < Admin::BaseController
  before_action :set_admin_access
  helper_method :sort_column, :sort_direction
 
  def index
    if params[:sort].present?
      @user_interested_coching_emails = UserInterestedCochingEmail.all.paginate(page: params[:page], per_page: 100).order(sort_column + " " + sort_direction)
    else  
      @user_interested_coching_emails = UserInterestedCochingEmail.all.paginate(page: params[:page], per_page: 10)
    end  
  end

  def new
    @user_interested_coching_email = UserInterestedCochingEmail.new
  end

  def show
    @user_interested_coching_email = UserInterestedCochingEmail.find(params[:id])
  end

  def edit
    @user_interested_coching_email = UserInterestedCochingEmail.find(params[:id])
  end  

  def create
    @user_interested_coching_email = UserInterestedCochingEmail.new(user_interested_coching_email)
    if @user_interested_coching_email.save
      redirect_to "/admin/user_interested_coching_emails", notice: t('controllers.admin.user_interested_coching_email.create')  
    else
      flash[:error] = t('controllers.admin.errors.message')
      render "new"
    end
  end

  def update
    @user_interested_coching_email = UserInterestedCochingEmail.find(params[:id])
    if @user_interested_coching_email.update_attributes(user_interested_coching_email)
      redirect_to "/admin/user_interested_coching_emails", notice: t('controllers.admin.user_interested_coching_email.update') 
    else
      render "edit"
    end
  end


  private

  def user_interested_coching_email
    params.require(:user_interested_coching_email).permit(:subject, :description)
  end

   def sort_column
    UserInterestedCochingEmail.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
