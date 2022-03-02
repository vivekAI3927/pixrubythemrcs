class Admin::QuestionCategoriesController < Admin::BaseController
  before_action :set_admin_access
  helper_method :sort_column, :sort_direction
 
  def index
    if params[:sort].present?
      @question_categories =  QuestionCategory.all.paginate(:page => params[:page], :per_page => 10).order(sort_column + " " + sort_direction)
    else
      @question_categories = QuestionCategory.all.paginate(:page => params[:page], :per_page => 10)
    end  
  end

  def new
    @question_category = QuestionCategory.new
  end

  def show
    @question_category = QuestionCategory.find(params[:id])
  end

  def edit
    @question_category = QuestionCategory.find(params[:id])
  end  

  def create
    @question_category = QuestionCategory.new(privacy_params)
    if @question_category.save
      redirect_to "/admin/question_categories", notice: t('controllers.admin.question_categories.create')  
    else
      render "new"
    end
  end

  def update
    @question_category = QuestionCategory.find(params[:id])
    if @question_category.update_attributes(privacy_params)
      redirect_to "/admin/question_categories", notice: t('controllers.admin.question_categories.update')
    else
      render "edit"
    end
  end

  private

  def privacy_params
    params.require(:question_category).permit(:title, :no_of_question)
  end

  def sort_column
    QuestionCategory.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
