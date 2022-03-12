class Admin::MembershipsController < Admin::BaseController
  before_action :set_admin_access
  before_action :set_membership, only: %i[show edit update destroy]
  helper_method :sort_column, :sort_direction

  def index
    if params[:sort].present?
    	@memberships =  Membership.all.paginate(:page => params[:page], :per_page => 10).order(sort_column + " " + sort_direction)
    else	
    	@memberships =  Membership.all.paginate(:page => params[:page], :per_page => 10).order("created_at DESC")
    end	
  end

  def new
    @membership = Membership.new
    if params[:user_id].present?
    	@user = User.find(params[:user_id])
    end	
  end

  def show
  end

  def create
    @membership = Membership.new(membership_params)
    if @membership.save
      redirect_to admin_memberships_path, notice: t('controllers.admin.memberships.create')
    else
      render "new"
    end
  end

  def edit
    @membership
  end

  def update
    respond_to do |format|
      if @membership.update(membership_params)
        format.html { redirect_to admin_membership_path(@membership), notice: t('controllers.admin.memberships.update') }
        format.json { render :show, status: :ok, location: @membership }
      else
        format.html { render :edit }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @membership.destroy
    respond_to do |format|
      format.html { redirect_to admin_memberships_path, notice: t('controllers.admin.memberships.destroy') }
      format.json { head :no_content }
    end
  end

  private

  def set_membership
    @membership = Membership.find(params[:id])
  end

  def membership_params
    params.require(:membership).permit(:stripe_plan_name,:status,:length, :price, :available, location: [])
  end 
  
  def sort_column
    Membership.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
