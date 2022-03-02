class Admin::UserJoinEmailsController < Admin::BaseController
  before_action :set_admin_access
  helper_method :sort_column, :sort_direction
 
  def index
    if params[:sort].present?
      @user_join_emails = UserJoinEmail.all.paginate(:page => params[:page], :per_page => 100).order(sort_column + " " + sort_direction)
    else  
      @user_join_emails = UserJoinEmail.all.paginate(:page => params[:page], :per_page => 10)
    end  
  end

  def new
    @user_join_email = UserJoinEmail.new
  end

  def show
    @user_join_email = UserJoinEmail.find(params[:id])
  end

  def edit
    @user_join_email = UserJoinEmail.find(params[:id])
  end  

  def create
    @user_join_email = UserJoinEmail.new(user_join_email)
    if @user_join_email.save
      redirect_to "/admin/user_join_emails", notice: t('controllers.admin.user_join_emails.create')  
    else
      flash[:error] = t('controllers.admin.errors.message')
      render "new"
    end
  end

  def update
    @user_join_email = UserJoinEmail.find(params[:id])
    if @user_join_email.update_attributes(user_join_email)
      redirect_to "/admin/user_join_emails", notice: t('controllers.admin.user_join_emails.update') 
    else
      render "edit"
    end
  end


  private

  def user_join_email
    params.require(:user_join_email).permit(:subject, :description)
  end

   def sort_column
    UserJoinEmail.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
