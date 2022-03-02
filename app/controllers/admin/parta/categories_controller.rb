class Admin::Parta::CategoriesController < Admin::BaseController
  # before_action :set_parta_category, only: [:show, :edit, :update, :destroy]
  before_action :set_admin_parta_access
  helper_method :sort_column, :sort_direction

  # GET /parta/categories
  # GET /parta/categories.json
  def index
    if params[:sort].present?
      @parta_categories = Parta::Category.all.paginate(:page => params[:page], :per_page => 10).reorder(sort_column + " " + sort_direction)
    else
      @parta_categories =  Parta::Category.order(:position).paginate(:page => params[:page], :per_page => 10)
    end 
  end

  # GET /parta/categories/1
  # GET /parta/categories/1.json
  def show
    @question = Parta::Question.new
    @parta_category = Parta::Category.find(params[:id])
  end

  # GET /parta/categories/new
  def new
    @parta_category = Parta::Category.new
  end

  # GET /parta/categories/1/edit
  def edit
    @parta_category = Parta::Category.find_by(id: params[:id])
  end

  # POST /parta/categories
  # POST /parta/categories.json
  def create
    @parta_category = Parta::Category.new(parta_category_params)

    respond_to do |format|
      if @parta_category.save
        format.html { redirect_to admin_parta_category_path(@parta_category.id), notice: t('controllers.admin.categories.update') }
        format.json { render :show, status: :created, location: @parta_category }
      else
        format.html { render :new }
        format.json { render json: @parta_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /parta/categories/1
  # PATCH/PUT /parta/categories/1.json
  def update
    @parta_category = Parta::Category.find_by(id: params[:id])
    respond_to do |format|
      if @parta_category.update(parta_category_params)
        format.html { redirect_to admin_parta_category_path(@parta_category.id), notice: t('controllers.admin.categories.update') }
        format.json { render :show, status: :ok, location: @parta_category }
      else
        format.html { render :edit }
        format.json { render json: @parta_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parta/categories/1
  # DELETE /parta/categories/1.json
  def destroy
    @parta_category = Parta::Category.find_by(id: params[:id])
    @parta_category.destroy
    respond_to do |format|
      format.html { redirect_to admin_parta_categories_path, notice: 'Category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_parta_category
      @parta_category = Parta::Category.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def parta_category_params
      params.require(:parta_category).permit(:name, :description, :image, :position, :parta_category_id)
    end
end
