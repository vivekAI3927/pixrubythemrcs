class Admin::CommunityCodesController < Admin::BaseController
  before_action :set_admin_access
  helper_method :sort_column, :sort_direction
 
  def index
    if params[:sort].present?
      @community_codes = CommunityCode.all.paginate(:page => params[:page], :per_page => 10).order(sort_column + " " + sort_direction)
    else 
      @community_codes = CommunityCode.all.paginate(:page => params[:page], :per_page => 10)
    end  
  end

  def new
    @community_code = CommunityCode.new
  end

  def edit
    @community_code = CommunityCode.find(params[:id])
  end  

  def create
    @community_code = CommunityCode.new(privacy_params)
    if @community_code.save
      redirect_to admin_community_codes_path, notice: t('controllers.admin.community_codes.create')  
    else
      render "new"
    end
  end

  def show
    @community_code = CommunityCode.find(params[:id])
  end

  def update
    @community_code = CommunityCode.find(params[:id])
    if @community_code.update_attributes(privacy_params)
      redirect_to admin_community_codes_path, notice: t('controllers.admin.community_codes.update')
    else
      render "edit"
    end
  end

  def destroy
    @community_code = CommunityCode.find(params[:id])
    @community_code.destroy
    respond_to do |format|
      format.html { redirect_to admin_community_codes_path, notice: t('controllers.admin.community_codes.destroy') }
      format.json { head :no_content }
    end
  end 

  def download_pdf
    @community_code = CommunityCode.find_by(id: params[:community_code_id])
    html = render_to_string(:action => 'download_pdf', :layout => false)
    pdf = PDFKit.new(html)
    send_data(pdf.to_pdf)
  end

  private

  def privacy_params
    params.require(:community_code).permit(:title, :description)
  end

  def sort_column
    CommunityCode.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
