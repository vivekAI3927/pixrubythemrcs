class Admin::PaymentContentsController < Admin::BaseController
  before_action :set_admin_access
  helper_method :sort_column, :sort_direction
 
  def index
   @payment_contents = PaymentContent.all.paginate(:page => params[:page], :per_page => 10)
  end

  def new
    @payment_content = PaymentContent.new
  end

  def show
    @payment_content = PaymentContent.find(params[:id])
  end

  def edit
    @payment_content = PaymentContent.find(params[:id])
  end  

  def create
    @payment_content = PaymentContent.new(privacy_params)
    if @payment_content.save
      redirect_to "/admin/payment_contents", notice: t('controllers.admin.payment_contents.create')
    else
      flash[:error] = t('controllers.admin.errors.message')
      render "new"
    end
  end

  def update
    @payment_content = PaymentContent.find(params[:id])
    if @payment_content.update_attributes(privacy_params)
      redirect_to "/admin/payment_contents", notice: t('controllers.admin.payment_contents.update')
    else
      flash[:alert] = t('controllers.admin.errors.message')
      render "edit"
    end
  end

  private

  def privacy_params
    params.require(:payment_content).permit(:stripe_declaration, :stripe, :paypal, :discount)
  end

  def sort_column
    PaymentContent.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
