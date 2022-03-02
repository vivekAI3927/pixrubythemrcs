class Admin::PricesController < Admin::BaseController
  before_action :set_admin_access
  helper_method :sort_column, :sort_direction
 
  def index
   # @prices = Price.all
    if params[:sort].present?
      @prices =  Price.all.paginate(:page => params[:page], :per_page => 10).order(sort_column + " " + sort_direction)
    else
      @prices = Price.all.where(["title LIKE (?) or title=?","%#{params[:search]}%",params[:search]]).paginate(:page => params[:page], :per_page => 10)
    end  
  end

  def new
    @price = Price.new
  end

  def show
    @price = Price.find_by(id: params[:id])
  end

  def get_filter_price
    if params[:price].present?
      price = params[:price]
      @prices = Price.all.where("price=?",price)
      @status = true
    elsif params[:status].present? 
        status = params[:status]
        @prices = Price.all.where("status=?",status)
        @status = true
    else
      @status = false
    end
  end

  def create
    @price = Price.new(price_params)
    if @price.save
      redirect_to admin_prices_path, notice: t('controllers.admin.prices.create')  
    else
      render "new"
    end
  end

  def edit
    @price = Price.find_by(id: params[:id])
  end

  def update
    @price = Price.find_by(id: params[:id])
    respond_to do |format|
      if @price.update(price_params)
        format.html { redirect_to admin_price_path(@price.id), notice: t('controllers.admin.prices.update') }
        format.json { render :show, status: :ok, location: @price }
      else
        format.html { render :edit }
        format.json { render json: @price.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @price = Price.find_by(id: params[:id])
    @price.destroy
    respond_to do |format|
      format.html { redirect_to admin_prices_path, notice: t('controllers.admin.prices.destroy') }
      format.json { head :no_content }
    end
  end 


  private

  def price_params
    params.require(:price).permit(:title, :price, :icon, :status)
  end

  def sort_column
    Price.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
