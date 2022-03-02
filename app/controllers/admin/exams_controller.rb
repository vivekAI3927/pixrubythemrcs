class Admin::ExamsController < Admin::BaseController
  before_action :set_admin_access
  helper_method :sort_column, :sort_direction

  def index
    if params[:sort].present?
      @exams =  Exam.all.paginate(:page => params[:page], :per_page => 10).order(sort_column + " " + sort_direction)
    else  
      @exams =  Exam.all.where(['stations LIKE ?', "%#{params[:search]}%"]).paginate(:page => params[:page], :per_page => 10).order("created_at DESC")
    end  
  end

  def show
    @exam = Exam.find_by(id: params[:id])
  end

  def new
    @exam = Exam.new
    # stations = []
    # anatomy_stations = Category.generate_random_stations("Anatomy", 3)
    # stations << anatomy_stations
    # communication_stations = Category.generate_random_stations("Communication Skills", 2)
    # stations << communication_stations
    # critical_stations = Category.generate_random_stations("Critical Care", 3)
    # stations << critical_stations
    # history_stations = Category.generate_random_stations("History Taking", 3)
    # stations << history_stations
    # operative_stations = Category.generate_random_stations("Operative Procedures", 2)
    # stations << operative_stations
    # path_stations = Category.generate_random_stations("Pathology", 1)
    # stations << path_stations
    # examination_stations = Category.generate_random_stations("Examination", 4)
    # stations << examination_stations

    # # flatten the arrays and shuffle them up!
    # stations = stations.flatten!
    # stations = stations.shuffle!
    # @exam = Exam.create(user_id: current_user.id, stations: stations, current_station: 0)

    # @first_station = Station.find(@exam.stations[@exam.current_station])
  end

  def create
    @exam = Exam.new(privacy_params)
    @stations = params[:exam][:stations].reject { |u| u.empty? }
    @exam.stations = @stations
    @exam.current_station = 0
    if @exam.save
      redirect_to admin_exams_path, notice: t('controllers.admin.exams.create')
    else
      flash[:error] = t('controllers.admin.errors.message')
      render "new"
    end

    # params[:exam][:stations].reject { |u| u.empty? }

    # @project = Project.find(params[:project_team][:project_id])
    # respond_to do |format|
    #   if params[:project_team][:user_id].present?
    #     @user =  params[:project_team][:user_id].reject { |u| u.empty? }
    #     @user.each do |user|
    #       @project_team = ProjectTeam.new(project_team_params)
    #       @project_team.user_id = user
    #       if @project_team.save
    #         format.html { redirect_to project_project_teams_path(@project), notice: 'Project team was successfully created.' }
    #         format.json { render :show, status: :created, location: @project_team }
    #       else
    #         format.html { render :new }
    #         format.json { render json: @project_team.errors, status: :unprocessable_entity }
    #       end
    #     end    
    #   end 
    # end

  end

  def next_station
    @exam = Exam.find(params[:id])

    if @exam && (@exam.current_station == (@exam.stations.count - 1))
      redirect_to review_exam_path(@exam.id)
    else
      next_station_id = Station.find(@exam.stations[@exam.current_station + 1])
      @exam.current_station += 1
      @exam.save
      redirect_to exam_station_path(@exam.id, next_station_id)
    end
  end

  def review
    @exam = Exam.find(params[:id])
    @stations = Station.find(@exam.stations)
  end

  def get_filter_exam
    if params[:user_id].present?
      user_id = params[:user_id]
      @exams = Exam.all.where("user_id=?",user_id)
      @status = true
    elsif params[:current_station].present? 
        current_station = params[:current_station]
        @exams = Exam.all.where("current_station =?",current_station)
        @status = true
    else
      @status = false
    end
    
  end

  private

  def privacy_params
    params.require(:exam).permit(:user_id, :current_station, :stations)
  end

  def sort_column
    Exam.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
