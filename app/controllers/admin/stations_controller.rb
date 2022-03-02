class Admin::StationsController < Admin::BaseController
  before_action :set_admin_access
	before_action :authenticate_user!, only: :toggle_attempt
	before_action :is_trial_false, except: [:index, :new, :create, :get_filter_station, :show, :edit, :update, :download_pdf, :destroy]
  helper_method :sort_column, :sort_direction

	def index
		@categories = Category.all.sort_by { |word| word.name.downcase }
    if params[:sort].present?
      @stations = Station.all.paginate(:page => params[:page], :per_page => 100).order(sort_column + " " + sort_direction)
      # @stations = Station.all.where("title ilike '%#{params[:search]}%'").paginate(:page => params[:page], :per_page => 10)
    else
      if params[:search].present?
        @stations = Station.all.where("title ilike '%#{params[:search]}%'").paginate(:page => params[:page], :per_page => 100).order("title ASC")
      else  
        @stations = Station.all.where("title ilike '%#{params[:search]}%'").paginate(:page => params[:page], :per_page => 100).order("created_at DESC")
      end  
    end  
	end

	def new
    @station = Station.new
    @categories =  Category.all.sort_by { |word| word.name.downcase }

  end

  def create
  	@station = Station.new(station_params)
    if @station.save!
      redirect_to admin_station_path(@station.id), notice: t('controllers.admin.stations.create')
    else
      render "new"
    end
 	end 	

	def show
    @question_data = Question.new
		# @station = Station.friendly.find(params[:id])
    @station = Station.find_by(id: params[:id])
		@question = @station.first_question
		@exam = Exam.find(params[:exam_id]) if params[:exam_id]

		if current_user && !@exam
			# mark station as started
			attempt = current_user.attempts.where(station_id: @station.id).first
			attempt.update_attribute(:started, true)

			# add first question to user history
			current_user.update_to_question_id(@question.id) rescue nil
		end
	end

	def edit
    # @station = Station.friendly.find(params[:id])
    @station = Station.find_by(id: params[:id])
  end


  def update
    @station = Station.friendly.find(params[:id])
    if params[:station][:remove_image] == "1"
      @station.image_file_name = nil
      if @station.update(station_params)
        redirect_to admin_station_path(@station.id), notice: t('controllers.admin.stations.update')
      else
        redirect_to "/admin/stations/#{@station.id}/edit"
      end
    else
      respond_to do |format|
        if @station.update(station_params)
          format.html { redirect_to admin_station_path(@station.id), notice: t('controllers.admin.stations.update') }
          format.json { render :show, status: :ok, location: @station }
        else
          format.html { render :edit }
          format.json { render json: @station.errors, status: :unprocessable_entity }
        end
      end
    end  
  end 

	def destroy
    @station = Station.find_by(id: params[:id])
		# @station = Station.friendly.find(params[:id])
    @station.destroy
    respond_to do |format|
      format.html { redirect_to admin_stations_path, notice: t('controllers.admin.stations.destroy') }
      format.json { head :no_content }
    end
  end

	def get_filter_station
    if params[:title].present?
      title = params[:title]
      @stations = Station.all.where("title=?",title)
      @status = true
    elsif params[:id].present? 
        id = params[:id]
        @stations = Station.where(category_id: id).order("title ASC")
        @status = true
    else
      @status = false
    end
  end

	def toggle_attempt
		@station = Station.friendly.find(params[:id])
		@attempt = Attempt.where(user_id: current_user.id, station_id: @station.id).first
		@attempt.user_toggle
		respond_to do |format|
			format.js
		end
	end

	private

  def station_params
    params.require(:station).permit(:title, :scenario_text, :category_id, :markscheme, :actor_brief, :exam_brief, :cheatsheet, :image_file_name, :trial, :available, :flag)
  end

  def sort_column
    Station.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
	
end
