class Parta::QuestionsController < ApplicationController

  # before_action :is_trial_false, except: [:index,:new, :create, :get_filter_question, :question_detail, :destroy, :edit, :update, :download_pdf, :move_up, :move_down, :destroy_question]

  helper_method :sort_column, :sort_direction


  def index
    @stations = Station.all
    if params[:sort].present?
      @questions = Question.all.paginate(:page => params[:page], :per_page => 100).order(sort_column + " " + sort_direction)
    else  
      @questions =  Question.all.where(['content LIKE ?', "%#{params[:search]}%"]).paginate(:page => params[:page], :per_page => 100).order("position ASC")
    end  
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    respond_to do |format|
      if params[:question][:via_station].present?
        if @question.save
          format.html { redirect_to admin_station_path(@question.station_id), notice: t('controllers.admin.questions.create') }
          format.json { render :show, status: :ok, location: @question }
        else
          format.html { render :new }
          format.json { render json: @question.errors, status: :unprocessable_entity }
        end
      else
        if @question.save
          format.html { redirect_to "/admin/questions/#{@question.id}/detail", notice: t('controllers.admin.questions.create') }
          format.json { render :show, status: :ok, location: @question }
        else
          format.html { render :new }
          format.json { render json: @question.errors, status: :unprocessable_entity }
        end
      end  
    end
  end 

  def get_filter_question
    if params[:position].present?
      position = params[:position]
      @questions = Question.all.where("position=?",position)
      @status = true
    elsif params[:id].present? 
      id = params[:id]
      @questions = Question.all.where("station_id =?",id)
      @status = true
    else
      @status = false
    end
  end

  def destroy
    @question = Question.find_by(id: params[:id])
    @question.destroy
    respond_to do |format|
      format.html { redirect_to admin_questions_path, notice: t('controllers.admin.questions.destroy') }
      format.json { head :no_content }
    end
  end

  def destroy_question
    @question = Question.find_by(id: params[:question_id])
    if @question.destroy
      redirect_to admin_station_path(@question.station_id), notice: t('controllers.admin.questions.create')
    end
  end

  def question_detail
   @question = Question.find_by(id: params[:question_id])  
  end  

  def edit
     @question = Question.find_by(id: params[:id])
  end

  def move_up
    @question = Question.find_by(id: params[:question_id])
    @question.move_higher
    redirect_back fallback_location: root_path
  end

  def move_down
    @question = Question.find_by(id: params[:question_id])
    @question.move_lower
    redirect_back fallback_location: root_path
  end

  def update
    if params[:question][:via_station].present?
      @question = Question.find_by(id: params[:id])
      @station_id = @question.station_id
      @station = Station.find_by(id: @station_id)
      if params[:question][:delete_image] == "1" || params[:question][:delete_answer_image] == "1"
        if params[:question][:delete_image] == "1"
          @question.image_file_name = nil
        end
        if params[:question][:delete_answer_image] == "1"
          @question.answer_image_file_name = nil
        end 
        if @question.update(question_params)
            redirect_to "/admin/stations/#{@station.id}", notice: t('controllers.admin.questions.update')
        else
          flash[:error] = t('controllers.admin.errors.message')
          redirect_to "/admin/questions/#{@question.id}/edit"
        end
      else
        respond_to do |format|
          if @question.update(question_params)
            format.html { redirect_to "/admin/stations/#{@station.id}", notice: t('controllers.admin.questions.update')  }
            format.json { render :show, status: :ok, location: @question }
          else
            format.html { render :edit }
            format.json { render json: @question.errors, status: :unprocessable_entity }
          end
        end
      end
    else  
      @question = Question.find_by(id: params[:id])
      if params[:question][:delete_image] == "1" || params[:question][:delete_answer_image] == "1"
        if params[:question][:delete_image] == "1"
          @question.image_file_name = nil
        end
        if params[:question][:delete_answer_image] == "1"
          @question.answer_image_file_name = nil
        end 
        if @question.update(question_params)
            redirect_to "/admin/questions/#{@question.id}/detail", notice: t('controllers.admin.questions.update')
        else
          flash[:error] = t('controllers.admin.errors.message')
          redirect_to "/admin/questions/#{@question.id}/edit"
        end
      else
        respond_to do |format|
          if @question.update(question_params)
            format.html { redirect_to "/admin/questions/#{@question.id}/detail", notice: t('controllers.admin.questions.update')  }
            format.json { render :show, status: :ok, location: @question }
          else
            format.html { render :edit }
            format.json { render json: @question.errors, status: :unprocessable_entity }
          end
        end
      end
    end  
  end
   

  def show
    # @station = Station.friendly.find(params[:station_id])
    # @question = @station.questions.where(:id => params[:id]).first
    if params[:category_id].present?
      @category = Parta::Category.friendly.find(params[:category_id]) rescue nil
      @question = @category.questions.where(:id => params[:id]).first rescue nil
    end 
    # @category =  Parta::Category.friendly.find(params[:category_id]) rescue nil
    @pos = 1 + params[:position].to_i rescue 0

    if current_parta_user
      @parta_category_status = @category.parta_category_status(current_parta_user)
      if @parta_category_status.blank?
        # update default status as 'TO-DO'
        @parta_category_status = @category.parta_update_status(current_parta_user, CATEGORY_TODO)
      end
    end
    # order_list = @category.questions.select(:id).all.map(&:id)
    # param_question = Parta::Question.find_by(id: params[:id]) rescue nil
    # current_position = order_list.index(param_question.id) rescue nil
    # @question = @category.questions.find(order_list[current_position + 1]) if order_list[current_position + 1] rescue nil


    # if @question.nil?
    #   redirect_to login_url, alert: "Not authorised"
    #   return
    # end
    # # for mock exams
    # @exam = Exam.find(params[:exam_id]) if params[:exam_id]

    # if current_user && !@exam

    #   # update user history
    #   if @question.last?(@station)
    #     current_user.update_to_question_id(nil)
    #   else
    #     current_user.update_to_question_id(@question.id)
    #   end

    #   # mark station as complete if question is last
    #   if @question.penultimate?(@station)
    #     attempt = Attempt.where(user_id: current_user.id, station_id: @station.id).first
    #     attempt.update_attribute(:completed, true)
    #   end
    # end
  end

  private

  def question_params
    params.require(:question).permit(:content, :position, :station_id, :answer_text, :image_text, :image_file_name, :answer_image, answers_attributes: [:id, :content, :correct, :_destroy])
  end

  def sort_column
    Question.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
