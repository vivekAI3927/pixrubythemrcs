class Admin::AttemptsController < Admin::BaseController
 
  def index
    @attempts = Attempt.all.paginate(:page => params[:page], :per_page => 10)
  end

  def new
    @attempt = Attempt.new
  end

  def show
    @attempt = Attempt.find_by(id: params[:id])
  end

  def edit
    @attempt = Attempt.find_by(id: params[:id])
  end 

  def update
    @attempt = Attempt.find_by(id: params[:id])
    if @attempt.update(attempt_params)
      format.html { redirect_to admin_attempt_path(@attempt.id), notice: t('controllers.admin.attempts.update') }
      format.json { render :show, status: :ok, location: @attempt }
    else
      format.html { render :edit }
      format.json { render json: @attempt.errors, status: :unprocessable_entity }
    end

  end

  def create
    @attempt = Attempt.new(attempt_params)
    if @attempt.save
      redirect_to admin_attempts_path, notice: t('controllers.admin.attempts.create')
    else
      render "new"
    end
  end 

  def destroy
    @attempt = Attempt.find_by(id: params[:id])
    @attempt.destroy
    respond_to do |format|
      format.html { redirect_to admin_attempts_path, notice: t('controllers.admin.attempts.destroy') }
      format.json { head :no_content }
    end
  end

  def get_filter_attempt
    if params[:user_id].present?
      user_id = params[:user_id]
      @attempts = Attempt.all.where("user_id=?",user_id)
      @status = true
    elsif params[:station_id].present? 
        station_id = params[:station_id]
        @attempts = Attempt.all.where("station_id =?",station_id)
        @status = true
    else
      @status = false
    end
  end 


  private

  def attempt_params
    params.require(:attempt).permit(:user_id, :station_id, :completed, :started)
  end 
    
end
