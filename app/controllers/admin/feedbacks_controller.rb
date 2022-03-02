class Admin::FeedbacksController < Admin::BaseController
  before_action :set_admin_access
  helper_method :sort_column, :sort_direction
 
  def index
    if params[:sort].present?
      @feedbacks =  Feedback.all.paginate(:page => params[:page], :per_page => 10).order(sort_column + " " + sort_direction)
    else
      @feedbacks = Feedback.all.paginate(:page => params[:page], :per_page => 10)
    end  
  end

  def new
    @feedback = Feedback.new
  end

  def show
    @feedback = Feedback.find_by(id: params[:id])
  end

  def edit
    @feedback = Feedback.find_by(id: params[:id])
  end

  def update
     @feedback = Feedback.find_by(id: params[:id])
    if @feedback.update(feedback_params)
      redirect_to "/admin/feedbacks/#{@feedback.id}", notice: t('controllers.admin.feedbacks.update')
    else
      render "edit"
    end
  end

  def destroy
    @feedback = Feedback.find_by(id: params[:id])
    @feedback.destroy
    respond_to do |format|
      format.html { redirect_to admin_feedbacks_path, notice: t('controllers.admin.feedbacks.destroy') }
      format.json { head :no_content }
    end
  end

  def download_pdf
    @feedback = Feedback.find_by(id: params[:feedback_id])
    html = render_to_string(:action => 'download_pdf', :layout => false)
    pdf = PDFKit.new(html)
    send_data(pdf.to_pdf)
  end  

  def create
    @feedback = Feedback.new(feedback_params)
    if @feedback.save
      redirect_to "/admin/feedbacks", notice: t('controllers.admin.feedbacks.create')  
    else
      render "new"
    end
  end
  private

  def feedback_params
    params.require(:feedback).permit(:name, :description, :status, :star_rating)
  end

  def sort_column
    Feedback.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
  
end
