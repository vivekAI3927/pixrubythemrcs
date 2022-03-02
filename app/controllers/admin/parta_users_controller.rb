class Admin::PartaUsersController < Admin::BaseController
  helper_method :sort_column, :sort_direction
  before_action :set_admin_access
  
  def index
    if params[:search_name].present? && !params[:search_email].present?
      @parta_users =  PartaUser.where('lower(name) LIKE lower(?)', "%#{params[:search_name]}%").paginate(:page => params[:page], :per_page => 100)
    elsif !params[:search_name].present? && params[:search_email].present?
      @parta_users =  PartaUser.all.where(['email LIKE ?', "%#{params[:search_email].downcase}%"]).paginate(:page => params[:page], :per_page => 100)
    elsif params[:search_name].present? && params[:search_email].present?
      @parta_users = PartaUser.where("name LIKE ? OR email LIKE ?" ,"%#{params[:search_name].downcase}%", "%#{params[:search_email].downcase}%").paginate(:page => params[:page], :per_page => 100)
    elsif params[:sort].present?
      @parta_users = PartaUser.all.where(["name LIKE (?) or email=?","%#{params[:search]}%",params[:search]]).paginate(:page => params[:page], :per_page => 100).order(sort_column + " " + sort_direction)  
    else
      @parta_users = PartaUser.all.where(["name LIKE (?) or email=?","%#{params[:search]}%",params[:search]]).paginate(:page => params[:page], :per_page => 100).order("created_at DESC")
    end    
  end

  def show
    @parta_user = PartaUser.find_by(id: params[:id])
  end
	
  def edit
    @parta_user = PartaUser.find_by(id: params[:id])
  end

	# NOTICE IS NOT DISPLYAING
	# CATCHIGN ERRORS IS PENDING
  def update
    if params[:parta_user][:password].present?
      if (params[:parta_user][:password] == params[:parta_user][:password_confirmation])
        @parta_user = PartaUser.find(params[:id])
        if @parta_user.update(parta_user_params)
          redirect_to "/admin/parta_users/#{@parta_user.id}", notice: t('controllers.admin.parta_users.update') 
        else
          render "edit"
        end
      else
        render "edit"
      end 
    else  
      @parta_user = PartaUser.find(params[:id])
      if @parta_user.update(parta_user_wopw_params)
        redirect_to "/admin/parta_users/#{@parta_user.id}", notice: t('controllers.admin.parta_users.update') 
      else
        render "edit"
      end
    end  
  end

  def destroy
    parta_user = PartaUser.find(params[:id])
    if parta_user
      parta_user.destroy
      redirect_to "/admin/parta_users", notice: t('controllers.admin.parta_users.destroy') 
    else
      flash[:error] = "An error occured. Try deleting #{parta_user.name} again."
    end
  end
	
	private
	def parta_user_params
    params.require(:parta_user).permit(:name, :email, :password, :password_confirmation, :target_exam_date, :country)
	end
	def parta_user_wopw_params
    params.require(:parta_user).permit(:name, :email, :target_exam_date, :country)
	end
	
  def sort_column
    PartaUser.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
