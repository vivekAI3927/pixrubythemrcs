class Admin::DisclaimersController < Admin::BaseController
  before_action :set_admin_access
  helper_method :sort_column, :sort_direction
 
  def index
    if params[:sort].present?
      @disclaimers = Disclaimer.all.paginate(:page => params[:page], :per_page => 10).order(sort_column + " " + sort_direction)
    else 
      @disclaimers = Disclaimer.all.paginate(:page => params[:page], :per_page => 10)
    end  
  end

  def new
    @disclaimer = Disclaimer.new
  end

  def edit
    @disclaimer = Disclaimer.find(params[:id])
  end  

  def create
    @disclaimer = Disclaimer.new(privacy_params)
    if @disclaimer.save
      redirect_to admin_disclaimers_path, notice: t('controllers.admin.disclaimers.create')  
    else
      render "new"
    end
  end

  def show
    @disclaimer = Disclaimer.find(params[:id])
  end

  def update
    @disclaimer = Disclaimer.find(params[:id])
    if @disclaimer.update_attributes(privacy_params)
      redirect_to admin_disclaimers_path, notice: t('controllers.admin.disclaimers.update')
    else
      render "edit"
    end
  end

  def destroy
    @disclaimer = Disclaimer.find(params[:id])
    @disclaimer.destroy
    respond_to do |format|
      format.html { redirect_to admin_disclaimers_path, notice: t('controllers.admin.disclaimers.destroy') }
      format.json { head :no_content }
    end
  end 

  def download_pdf
    @disclaimer = Disclaimer.find_by(id: params[:disclaimer_id])
    html = render_to_string(:action => 'download_pdf', :layout => false)
    pdf = PDFKit.new(html)
    send_data(pdf.to_pdf)
  end

  private

  def privacy_params
    params.require(:disclaimer).permit(:title, :description)
  end

  def sort_column
    Disclaimer.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
