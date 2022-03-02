class Admin::MemberFeedbacksController < Admin::BaseController
  before_action :set_admin_access
  
  def index
   @member_feedbacks =  MemberFeedback.all.paginate(:page => params[:page], :per_page => 10)
  end

  def new
    @member_feedback = MemberFeedback.new
  end

  def destroy
    @member_feedback = MemberFeedback.find_by(id: params[:id])
    @member_feedback.destroy
    respond_to do |format|
      format.html { redirect_to admin_member_feedbacks_path, notice: t('controllers.admin.member_feedbacks.destroy') }
      format.json { head :no_content }
    end
  end

  def show
    @member_feedback = MemberFeedback.find_by(id: params[:id])
  end

  def edit
    @member_feedback = MemberFeedback.find_by(id: params[:id])
  end

  def create
    @member_feedback = MemberFeedback.new(member_feedback_params)
    if @member_feedback.save
      redirect_to "/admin/member_feedbacks", notice: t('controllers.admin.member_feedbacks.create')  
    else
      flash[:error] = t('controllers.admin.errors.message')
      render "new"
    end
  end

  def update
     @member_feedback = MemberFeedback.find_by(id: params[:id])
    if @member_feedback.update(member_feedback_params)
      redirect_to "/admin/member_feedbacks", notice: t('controllers.admin.member_feedbacks.update')  
    else
      flash[:error] = t('controllers.admin.errors.message')
      redirect_to "/admin/member_feedbacks/#{@member_feedback.id}/edit"
    end
  end

  private

  def member_feedback_params
    params.require(:member_feedback).permit(:section_one, :section_two)
  end

end
