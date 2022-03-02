class Admin::ResourcesController < Admin::BaseController
  before_action :set_admin_access
  helper_method :sort_column, :sort_direction
 
  def index
    if params[:sort].present?
      @resources =  Resource.all.paginate(:page => params[:page], :per_page => 10).order(sort_column + " " + sort_direction)
    else
      @resources =  Resource.all.where(['title LIKE ?', "%#{params[:search]}%"]).paginate(:page => params[:page], :per_page => 10).order("created_at DESC")
    end  
  end

  def new
    @resource = Resource.new
  end

  def destroy
    @resource = Resource.find_by(id: params[:id])
    @resource.destroy
    respond_to do |format|
      format.html { redirect_to admin_resources_path, notice: t('controllers.admin.resources.destroy') }
      format.json { head :no_content }
    end
  end

  def show
    @resource = Resource.find_by(id: params[:id])
  end

  def edit
    @resource = Resource.find_by(id: params[:id])
  end

  def create
    @resource = Resource.new(resource_params)
    if @resource.save
      redirect_to "/admin/resources", notice: t('controllers.admin.resources.create')  
    else
      render "new"
    end
  end

  def update
     @resource = Resource.find_by(id: params[:id])
    if @resource.update(resource_params)
      redirect_to "/admin/resources/#{@resource.id}", notice: t('controllers.admin.resources.update')  
    else
      render "edit"
    end
  end 

  private
  
  def resource_params
    params.require(:resource).permit(:title, :description, :available, :image_file_name)
  end

  def sort_column
    Resource.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
