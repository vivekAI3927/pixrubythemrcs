class Admin::PrivacyTermsController < Admin::BaseController
  before_action :set_admin_access
  helper_method :sort_column, :sort_direction
 
  def index
    if params[:sort].present?
      @privacy_terms = PrivacyTerm.all.paginate(:page => params[:page], :per_page => 10).order(sort_column + " " + sort_direction)
    else 
      @privacy_terms = PrivacyTerm.all.paginate(:page => params[:page], :per_page => 10)
    end  
  end

  def new
    @privacy_term = PrivacyTerm.new
  end

  def edit
    @privacy_term = PrivacyTerm.find(params[:id])
  end  

  def create
    @privacy_term = PrivacyTerm.new(privacy_params)
    if @privacy_term.save
      redirect_to "/admin/privacy_terms", notice: t('controllers.admin.privacy_terms.create')  
    else
      render "new"
    end
  end

  def show
    @privacy_term = PrivacyTerm.find(params[:id])
  end

  def update
    @privacy_term = PrivacyTerm.find(params[:id])
    if @privacy_term.update_attributes(privacy_params)
      redirect_to "/admin/privacy_terms", notice: t('controllers.admin.privacy_terms.update') 
    else
      render "edit"
    end
  end

  def destroy
    @privacy_term = PrivacyTerm.find(params[:id])
    @privacy_term.destroy
    respond_to do |format|
      format.html { redirect_to admin_privacy_terms_path, notice: t('controllers.admin.privacy_terms.destroy')  }
      format.json { head :no_content }
    end
  end 

  private

  def privacy_params
    params.require(:privacy_term).permit(:title, :term_and_condition, :note, :status)
  end

  def sort_column
    PrivacyTerm.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
