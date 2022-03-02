class Admin::CoursesController < Admin::BaseController
  before_action :set_admin_access
  helper_method :sort_column, :sort_direction
 
  def index
    if params[:sort].present?
      @courses = Course.all.paginate(:page => params[:page], :per_page => 10).order(sort_column + " " + sort_direction)
    else  
      @courses = Course.all.where(["description LIKE (?) or booking=?","%#{params[:search]}%",params[:search]]).paginate(:page => params[:page], :per_page => 10)
    end
  end
  

  def new
    @course = Course.new
  end

  def show
    @course = Course.find_by(id: params[:id])
    # @course = Course.find_by_slug(params[:id])
  end

  def destroy
    @course = Course.find_by(id: params[:id])
    @course.destroy
    respond_to do |format|
      format.html { redirect_to admin_courses_path, notice: t('controllers.admin.courses.destroy') }
      format.json { head :no_content }
    end
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      redirect_to admin_courses_path, notice: t('controllers.admin.courses.create')
    else
      render "new"
    end
  end 

  def edit
    @course = Course.find_by(id: params[:id])
  end

  def update
    @course = Course.find_by(id: params[:id])
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to admin_course_path(@course.id), notice: t('controllers.admin.courses.update') }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end 

  def get_filter_course
    if params[:title].present?
      title = params[:title]
      @courses = Course.all.where("title=?",title)
      @status = true
    elsif params[:member_code].present? 
        member_code = params[:member_code]
        @courses = Course.all.where("member_code =?",member_code)
        @status = true
    else
      @status = false
    end
  end 

  private

  def course_params
    params.require(:course).permit(:title, :description, :booking, :member_code, :image_file_name, :available)
  end 

  def sort_column
    Course.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
    
end
