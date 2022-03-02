# frozen_string_literal: true

class Admin::AdminsController < Admin::BaseController
  # skip_before_action  :verify_authenticity_token
  before_action :set_admin_access
  helper_method :sort_column, :sort_direction

  def index
    @admins = Admin.paginate(page: params[:page])
    if params[:sort].present?
      @admin_users =  Admin.all.paginate(:page => params[:page], :per_page => 100).order(sort_column + " " + sort_direction)
    else
      @admin_users =  Admin.all.where(['email LIKE ?', "%#{params[:search]}%"]).paginate(:page => params[:page], :per_page => 100)
    end  
  end

  def new
    @admin = Admin.new
  end

  def show
    @admin_user = Admin.find_by(id: params[:id])   
  end

  def get_filter_admin_user
    if params[:email].present?
      email = params[:email]
      @admin_users = Admin.all.where("email=?",email)
      @status = true
    elsif params[:editor].present? 
        editor = params[:editor]
        @admin_users = Admin.all.where("editor =?",editor)
        @status = true
    else
      @status = false
    end
  end

  def edit
    @admin = Admin.find_by(id: params[:id])
  end

  def create
    if params[:admin_user].present?
      @admin = Admin.new(admin_user_params)
      if @admin.save
        redirect_to "/admin/admins", notice: t('controllers.admin.admins.create') 
      else
        render "new"
      end
    end   
    if params[:admin].present?
      @admin = Admin.new(admin_params)
      respond_to do |format|
        if @admin.save
          format.html { redirect_to admin_admin_path(@admin), notice: t('controllers.admin.admins.create') }
          format.json { render :show, status: :created, location: @admin }
        else
          format.html { render :new }
          format.json { render json: @admin.errors, status: :unprocessable_entity }
        end
      end
    end  
  end

  def update
    @admin = Admin.find_by(id: params[:id])
    respond_to do |format|
      if @admin.update(admin_params)
        format.html { redirect_to admin_admin_path(@admin), notice: t('controllers.admin.admins.update') }
        format.json { render :show, status: :ok, location: @admin }
      else
        format.html { render :edit }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @admin = Admin.find_by(id: params[:id])
    @admin.destroy
    respond_to do |format|
      format.html { redirect_to admin_admins_url, notice: t('controllers.admin.admins.destroy') }
      format.json { head :no_content }
    end
  end

  private

  def set_client
    @admin = Admin.find(params[:id])
  end

  def admin_params
    params.require(:admin).permit(:id, :type, :email, :password, :password_confirmation, :super_admin, profile_attributes: %i[first_name last_name dob gender mobile_number address country state city avatar description file ])
  end

  def admin_user_params
    params.require(:admin_user).permit(:email, :password, :password_confirmation, :editor)
  end

  def sort_column
    Admin.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
