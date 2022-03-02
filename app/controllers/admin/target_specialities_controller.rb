class Admin::TargetSpecialitiesController < Admin::BaseController
  before_action :set_admin_access
  helper_method :sort_column, :sort_direction
 
  def index
    if params[:sort].present?
      @target_specialities =  TargetSpeciality.all.paginate(:page => params[:page], :per_page => 10).order(sort_column + " " + sort_direction)
    else
      @target_specialities = TargetSpeciality.all.paginate(:page => params[:page], :per_page => 10)
    end  
  end

  def new
    @target_speciality = TargetSpeciality.new
  end

  def show
    @target_speciality = TargetSpeciality.find_by(id: params[:id])
  end

  def destroy
    @target_speciality = TargetSpeciality.find_by(id: params[:id])
    @target_speciality.destroy
    respond_to do |format|
      format.html { redirect_to admin_target_specialities_path, notice: t('controllers.admin.target_specialities.destroy') }
      format.json { head :no_content }
    end
  end

  def create
    @target_speciality = TargetSpeciality.new(target_speciality_params)
    if @target_speciality.save
      redirect_to "/admin/target_specialities", notice: t('controllers.admin.target_specialities.create')  
    else
      render "new"
    end
  end

  def edit
    @target_speciality = TargetSpeciality.find_by(id: params[:id])
  end

  def update
    @target_speciality = TargetSpeciality.find_by(id: params[:id])
    if @target_speciality.update(target_speciality_params)
      redirect_to "/admin/target_specialities/#{@target_speciality.id}", notice: t('controllers.admin.target_specialities.update')
    else
      render "edit"
    end
  end 


  private

  def target_speciality_params
    params.require(:target_speciality).permit(:name)
  end

  def sort_column
    TargetSpeciality.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
