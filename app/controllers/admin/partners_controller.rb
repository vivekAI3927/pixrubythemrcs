class Admin::PartnersController < Admin::BaseController
  before_action :set_admin_access
  
  def index
   @partners = Partner.all.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @partner = Partner.find_by(id: params[:id])
  end

  def new
    @partner = Partner.new
  end

  def edit
    @partner = Partner.find_by(id: params[:id])
  end

  def create
    @partner = Partner.new(partner_params)
    if @partner.save
      redirect_to admin_partners_path, notice: t('controllers.admin.partners.create')
    else
      render "new"
    end
  end

  def update
     @partner = Partner.find_by(id: params[:id])
    if @partner.update(partner_params)
      redirect_to "/admin/partners/#{@partner.id}", notice: t('controllers.admin.partners.update')  
    else
      flash[:error] = t('controllers.admin.errors.message')
      redirect_to "/admin/partners/#{@partner.id}/edit"
    end
  end

  private

  def partner_params
    params.require(:partner).permit(:description, :image)
  end

end
