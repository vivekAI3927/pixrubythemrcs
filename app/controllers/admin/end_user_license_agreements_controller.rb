class Admin::EndUserLicenseAgreementsController < Admin::BaseController
  before_action :set_admin_access
  helper_method :sort_column, :sort_direction
 
  def index
    if params[:sort].present?
      @end_user_license_agreements = EndUserLicenseAgreement.all.paginate(:page => params[:page], :per_page => 10).order(sort_column + " " + sort_direction)
    else 
      @end_user_license_agreements = EndUserLicenseAgreement.all.paginate(:page => params[:page], :per_page => 10)
    end  
  end

  def new
    @end_user_license_agreement = EndUserLicenseAgreement.new
  end

  def edit
    @end_user_license_agreement = EndUserLicenseAgreement.find(params[:id])
  end  

  def create
    @end_user_license_agreement = EndUserLicenseAgreement.new(privacy_params)
    if @end_user_license_agreement.save
      redirect_to admin_end_user_license_agreements_path, notice: t('controllers.admin.end_user_license_agreements.create')  
    else
      flash[:error] = t('controllers.admin.errors.message')
      render "new"
    end
  end

  def show
    @end_user_license_agreement = EndUserLicenseAgreement.find(params[:id])
  end

  def update
    @end_user_license_agreement = EndUserLicenseAgreement.find(params[:id])
    if @end_user_license_agreement.update_attributes(privacy_params)
      redirect_to admin_end_user_license_agreements_path, notice: t('controllers.admin.end_user_license_agreements.update')
    else
      render "edit"
    end
  end

  def destroy
    @end_user_license_agreement = EndUserLicenseAgreement.find(params[:id])
    @end_user_license_agreement.destroy
    respond_to do |format|
      format.html { redirect_to admin_end_user_license_agreements_path, notice: t('controllers.admin.end_user_license_agreements.destroy') }
      format.json { head :no_content }
    end
  end 

  def download_pdf
    @end_user_license_agreement = EndUserLicenseAgreement.find_by(id: params[:end_user_license_agreement_id])
    html = render_to_string(:action => 'download_pdf', :layout => false)
    pdf = PDFKit.new(html)
    send_data(pdf.to_pdf)
  end

  private

  def privacy_params
    params.require(:end_user_license_agreement).permit(:title, :description)
  end

  def sort_column
    EndUserLicenseAgreement.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
