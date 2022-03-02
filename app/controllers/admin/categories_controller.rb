class Admin::CategoriesController < Admin::BaseController
  before_action :set_admin_access
	before_action :get_categories
  before_action :set_category, only: %i[show edit update destroy agents campaigns orders]
  helper_method :sort_column, :sort_direction
  # skip_before_action  :verify_authenticity_token
  
  def index
    if params[:sort].present?
      @categories = Category.all.paginate(:page => params[:page], :per_page => 10).reorder(sort_column + " " + sort_direction)
    else
      @categories =  Category.order(:position).paginate(:page => params[:page], :per_page => 10)
    end   
  end

  def new
    @category = Category.new
  end

  def show
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_categories_path, notice: t('controllers.admin.categories.create')
    else
      render "new"
    end
  end

  def edit
    @category
  end

  def update
    @category = Category.find_by(id: params[:id])
    if params[:category][:available] == "1"
      respond_to do |format|
        @category.image_file_name = nil
        if @category.update(category_params)
          format.html { redirect_to admin_category_path(@category.id), notice: t('controllers.admin.categories.update') }
          format.json { render :show, status: :ok, location: @category }
        else
          format.html { render :edit }
          format.json { render json: @category.errors, status: :unprocessable_entity }
        end
      end
    else 
      respond_to do |format|
        if @category.update(category_params)
          format.html { redirect_to admin_category_path(@category.id), notice: t('controllers.admin.categories.update') }
          format.json { render :show, status: :ok, location: @category }
        else
          format.html { render :edit }
          format.json { render json: @category.errors, status: :unprocessable_entity }
        end
      end
    end  
  end

  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to admin_categories_path, notice: t('controllers.admin.categories.destroy') }
      format.json { head :no_content }
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def get_categories
    @categories = Category.order(:position)
  end

  def category_params
    params.require(:category).permit(:name, :advice,:image_file_name, :position)
  end
 
  def sort_column
    Category.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
