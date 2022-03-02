class Admin::CouponsController < Admin::BaseController
  before_action :set_admin_access
  before_action :set_coupon, only: %i[show edit update destroy]
  helper_method :sort_column, :sort_direction

  def index
    if params[:sort].present?
      @coupons =  Coupon.all.paginate(:page => params[:page], :per_page => 10).order(sort_column + " " + sort_direction)
    else
      @coupons =  Coupon.all.paginate(:page => params[:page], :per_page => 10).order("created_at DESC")
    end    
  end

  def new
    @coupon = Coupon.new
  end

  def show
  end

  def create
    @coupon = Coupon.new(coupon_params)

    if @coupon.save
      redirect_to admin_coupons_path, notice: t('controllers.admin.coupons.create')
    else
      render "new"
    end
  end

  def edit
    @coupon
  end

  def update
    respond_to do |format|
      if @coupon.update(coupon_params)
        format.html { redirect_to admin_coupon_path(@coupon), notice: t('controllers.admin.coupons.update') }
        format.json { render :show, status: :ok, location: @coupon }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @coupon.destroy
    respond_to do |format|
      format.html { redirect_to admin_coupons_path, notice: t('controllers.admin.coupons.destroy') }
      format.json { head :no_content }
    end
  end
 
  private

  def set_coupon
    @coupon = Coupon.find(params[:id])
  end

  def coupon_params
    params.require(:coupon).permit(:name, :discount,:uses)
  end 

  def sort_column
    Coupon.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
  
end
