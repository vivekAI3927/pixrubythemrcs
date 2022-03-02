class Admin::CookiePoliciesController < Admin::BaseController
  before_action :set_admin_access
  helper_method :sort_column, :sort_direction
 
  def index
    if params[:sort].present?
      @cookie_policies = CookiePolicy.all.paginate(:page => params[:page], :per_page => 10).order(sort_column + " " + sort_direction)
    else 
      @cookie_policies = CookiePolicy.all.paginate(:page => params[:page], :per_page => 10)
    end  
  end

  def new
    @cookie_policy = CookiePolicy.new
  end

  def edit
    @cookie_policy = CookiePolicy.find(params[:id])
  end  

  def create
    @cookie_policy = CookiePolicy.new(privacy_params)
    if @cookie_policy.save
      redirect_to admin_cookie_policies_path, notice: t('controllers.admin.cookie_policies.create')  
    else
      render "new"
    end
  end

  def show
    @cookie_policy = CookiePolicy.find(params[:id])
  end

  def update
    @cookie_policy = CookiePolicy.find(params[:id])
    if @cookie_policy.update_attributes(privacy_params)
      redirect_to admin_cookie_policies_path, notice: t('controllers.admin.cookie_policies.update')
    else
      render "edit"
    end
  end

  def destroy
    @cookie_policy = CookiePolicy.find(params[:id])
    @cookie_policy.destroy
    respond_to do |format|
      format.html { redirect_to admin_cookie_policies_path, notice: t('controllers.admin.cookie_policies.destroy') }
      format.json { head :no_content }
    end
  end 

  def download_pdf
    @cookie_policy = CookiePolicy.find_by(id: params[:cookie_policy_id])
    html = render_to_string(:action => 'download_pdf', :layout => false)
    pdf = PDFKit.new(html)
    send_data(pdf.to_pdf)
  end

  private

  def privacy_params
    params.require(:cookie_policy).permit(:title, :description)
  end

  def sort_column
    CookiePolicy.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
