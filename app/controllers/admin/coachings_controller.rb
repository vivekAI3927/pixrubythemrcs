class Admin::CoachingsController < Admin::BaseController
  before_action :set_admin_access
  helper_method :sort_column, :sort_direction
 
  def index
    if params[:sort].present?
      @coachings = Coaching.all.paginate(:page => params[:page], :per_page => 10).order(sort_column + " " + sort_direction)
    else  
      @coachings = Coaching.all.paginate(:page => params[:page], :per_page => 10)
    end
  end
  

  def new
    @coaching = Coaching.new
  end

  def show
    @coaching = Coaching.find_by(id: params[:id])
    # @coaching = Coaching.find_by_slug(params[:id])
  end

  def destroy
    @coaching = Coaching.find_by(id: params[:id])
    @coaching.destroy
    respond_to do |format|
      format.html { redirect_to admin_coachings_path, notice: t('controllers.admin.coachings.destroy') }
      format.json { head :no_content }
    end
  end

  def create
    @coaching = Coaching.new(coaching_params)
    if @coaching.save
      redirect_to admin_coachings_path, notice: t('controllers.admin.coachings.create')
    else
      render "new"
    end
  end 

  def edit
    @coaching = Coaching.find_by(id: params[:id])
  end

  def update
    @coaching = Coaching.find_by(id: params[:id])
    respond_to do |format|
      if @coaching.update(coaching_params)
        format.html { redirect_to admin_coaching_path(@coaching.id), notice: t('controllers.admin.coachings.update') }
        format.json { render :show, status: :ok, location: @coaching }
      else
        format.html { render :edit }
        format.json { render json: @coaching.errors, status: :unprocessable_entity }
      end
    end
  end 

  def get_filter_coaching
    if params[:title].present?
      title = params[:title]
      @coachings = Coaching.all.where("title=?",title)
      @status = true
    elsif params[:member_code].present? 
        member_code = params[:member_code]
        @coachings = Coaching.all.where("member_code =?",member_code)
        @status = true
    else
      @status = false
    end
  end 

  private

  def coaching_params
    params.require(:coaching).permit(:title, :description)
  end 

  def sort_column
    Coaching.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
