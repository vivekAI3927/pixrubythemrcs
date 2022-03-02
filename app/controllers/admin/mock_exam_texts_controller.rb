class Admin::MockExamTextsController < Admin::BaseController
  before_action :set_admin_access

  def index
   @mock_exam_texts =  MockExamText.all.paginate(:page => params[:page], :per_page => 10)
  end

  def new
    @mock_exam_text = MockExamText.new
  end

  def destroy
    @mock_exam_text = MockExamText.find_by(id: params[:id])
    @mock_exam_text.destroy
    respond_to do |format|
      format.html { redirect_to admin_mock_exam_texts_path, notice: t('controllers.admin.mock_exam_texts.destroy') }
      format.json { head :no_content }
    end
  end

  def show
    @mock_exam_text = MockExamText.find_by(id: params[:id])
  end

  def edit
    @mock_exam_text = MockExamText.find_by(id: params[:id])
  end

  def create
    @mock_exam_text = MockExamText.new(mock_exam_text_params)
    if @mock_exam_text.save
      redirect_to "/admin/mock_exam_texts", notice: t('controllers.admin.mock_exam_texts.create')  
    else
      render "new"
    end
  end

  def update
     @mock_exam_text = MockExamText.find_by(id: params[:id])
    if @mock_exam_text.update(mock_exam_text_params)
      redirect_to "/admin/mock_exam_texts", notice: t('controllers.admin.mock_exam_texts.update') 
    else
      render "edit"
    end
  end

  private

  def mock_exam_text_params
    params.require(:mock_exam_text).permit(:description, :title)
  end

end
