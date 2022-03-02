class Admin::FaqsController < Admin::BaseController
  before_action :set_admin_access
  helper_method :sort_column, :sort_direction
 
  def index
    if params[:sort].present?
      @faqs =  Faq.all.paginate(:page => params[:page], :per_page => 50).order(sort_column + " " + sort_direction)
    else
      @faqs = Faq.all.where(["title LIKE (?) or title=?","%#{params[:search]}%",params[:search]]).paginate(:page => params[:page], :per_page => 50)
    end  
  end

  def new
    @faq = Faq.new
  end

  def destroy
    @faq = Faq.find_by(id: params[:id])
    @faq.destroy
    respond_to do |format|
      format.html { redirect_to admin_faqs_path, notice: t('controllers.admin.faqs.destroy') }
      format.json { head :no_content }
    end
  end

  def show
    @faq = Faq.find_by(id: params[:id])
  end

  def edit
    @faq = Faq.find_by(id: params[:id])
  end

  def create
    @faq = Faq.new(faq_params)
    if @faq.save
      redirect_to "/admin/faqs", notice: t('controllers.admin.faqs.create')  
    else
      render "new"
    end
  end

  def update
     @faq = Faq.find_by(id: params[:id])
    if @faq.update(faq_params)
      redirect_to "/admin/faqs/#{@faq.id}", notice: t('controllers.admin.faqs.update')
    else
      render "edit"
    end
  end 

  private

  def faq_params
    params.require(:faq).permit(:title, :description, :status, :rank)
  end

  def sort_column
    Faq.column_names.include?(params[:sort]) ? params[:sort] : "rank" 
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
