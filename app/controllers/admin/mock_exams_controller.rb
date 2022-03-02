class Admin::MockExamsController < Admin::BaseController
  before_action :set_admin_access
  
  def index
   @mock_exams =  MockExam.all.paginate(:page => params[:page], :per_page => 10)
  end

  def new
    @mock_exam = MockExam.new
  end

  def destroy
    @mock_exam = MockExam.find_by(id: params[:id])
    @mock_exam.destroy
    respond_to do |format|
      format.html { redirect_to admin_mock_exams_path, notice: t('controllers.admin.mock_exams.destroy') }
      format.json { head :no_content }
    end
  end

  def show
    @mock_exam = MockExam.find_by(id: params[:id])
  end

  def edit
    @mock_exam = MockExam.find_by(id: params[:id])
  end

  def create
    @mock_exam = MockExam.new(mock_exam_params)
    if @mock_exam.save
      redirect_to "/admin/mock_exams", notice: t('controllers.admin.mock_exams.create')  
    else
      render "new"
    end
  end

  def update
     @mock_exam = MockExam.find_by(id: params[:id])
    if @mock_exam.update(mock_exam_params)
      redirect_to "/admin/mock_exams", notice: t('controllers.admin.mock_exams.update') 
    else
      render "edit"
    end
  end

  private

  def mock_exam_params
    params.require(:mock_exam).permit(:description, :title)
  end

end
