class Admin::Parta::QuestionsController < Admin::BaseController
  before_action :set_admin_parta_access
  before_action :is_trial_false, except: [:index,:new, :create, :get_filter_question, :question_detail, :destroy, :edit, :update, :download_pdf, :move_up, :move_down, :destroy_question, :show]

  helper_method :sort_column, :sort_direction


  def index
    @parta_categories = Parta::Category.all
    if params[:sort].present?
      @questions = Parta::Question.all.paginate(:page => params[:page], :per_page => 100).order(sort_column + " " + sort_direction)
    else  
      @questions =  Parta::Question.all.where(['content LIKE ?', "%#{params[:search]}%"]).paginate(:page => params[:page], :per_page => 100).order("position ASC")
    end  
  end

  def new
    @question = Parta::Question.new
    # @question.answers.build
  4.times { @question.answers.build } # you can do it dynamically

  end

  def create
    @question = Parta::Question.new(parta_question_params)
    respond_to do |format|
      if params[:parta_question][:via_station].present?
        if @question.save
          format.html { redirect_to admin_parta_category_path(@question.parta_category_id)}
          format.json { render :show, status: :ok, location: @question }
        else
          format.html { render :new }
          format.json { render json: @question.errors, status: :unprocessable_entity }
        end
      else
        if @question.save
          format.html { redirect_to "/admin/parta/questions/#{@question.id}", notice: t('controllers.admin.questions.create') }
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
      @questions = Parta::Question.all.where("position=?",position)
      @status = true
    elsif params[:id].present? 
      id = params[:id]
      @questions = Parta::Question.all.where("station_id =?",id)
      @status = true
    else
      @status = false
    end
  end

  def destroy
    @question = Parta::Question.find_by(id: params[:id])
    @question.destroy
    respond_to do |format|
      format.html { redirect_to admin_parta_questions_path, notice: t('controllers.admin.questions.destroy') }
      format.json { head :no_content }
    end
  end

  def destroy_question
    @question = Parta::Question.find_by(id: params[:question_id])
    if @question.destroy
      redirect_to "/admin/parta/categories/#{@question.parta_category_id}", notice: t('controllers.admin.questions.update')
    end
  end

  def move_up
    @question = Parta::Question.find_by(id: params[:question_id])
    @question.move_higher
    redirect_back fallback_location: root_path
  end

  def move_down
    @question = Parta::Question.find_by(id: params[:question_id])
    @question.move_lower
    redirect_back fallback_location: root_path
  end

  def question_detail
   @question = Parta::Question.find_by(id: params[:question_id])  
  end  

  def edit
    @question = Parta::Question.find_by(id: params[:id])
  end

  def move_up
    @question = Parta::Question.find_by(id: params[:question_id])
    @question.move_higher
    redirect_back fallback_location: root_path
  end

  def move_down
    @question = Parta::Question.find_by(id: params[:question_id])
    @question.move_lower
    redirect_back fallback_location: root_path
  end

  def update
    if params[:parta_question][:via_station].present?
      @question = Parta::Question.find_by(id: params[:id])
      @parta_category_id = @question.parta_category_id
      @parta_category = Parta::Category.find_by(id: @parta_category_id)
      if params[:parta_question][:delete_image] == "1" || params[:parta_question][:delete_answer_image] == "1"
        if params[:parta_question][:delete_image] == "1"
          @question.image = nil
        end
        if params[:parta_question][:delete_answer_image] == "1"
          @question.answer_image = nil
        end 
        if @question.update(parta_question_params)
            redirect_to "/admin/parta/categories/#{@parta_category.id}", notice: t('controllers.admin.questions.update')
        else
          flash[:error] = t('controllers.admin.errors.message')
          redirect_to "/admin/questions/#{@question.id}/edit"
        end
      else
        respond_to do |format|
          if @question.update(parta_question_params)
            format.html { redirect_to "/admin/parta/categories/#{@parta_category.id}", notice: t('controllers.admin.questions.update')  }
            format.json { render :show, status: :ok, location: @question }
          else
            format.html { render :edit }
            format.json { render json: @question.errors, status: :unprocessable_entity }
          end
        end
      end
    else  
      @question = Parta::Question.find_by(id: params[:id])
      if params[:parta_question][:delete_image] == "1" || params[:parta_question][:delete_answer_image] == "1"
        if params[:parta_question][:delete_image] == "1"
          @question.image = nil
        end
        if params[:parta_question][:delete_answer_image] == "1"
          @question.answer_image = nil
        end 
        if @question.update(parta_question_params)
            redirect_to "/admin/parta/questions/#{@question.id}", notice: t('controllers.admin.questions.update')
        else
          flash[:error] = t('controllers.admin.errors.message')
          redirect_to "/admin/questions/#{@question.id}/edit"
        end
      else
        respond_to do |format|
          if @question.update(parta_question_params)
            format.html { redirect_to "/admin/parta/questions/#{@question.id}", notice: t('controllers.admin.questions.update')  }
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
  	# @parta_category = Parta::Category.friendly.find(params[:station_id])
  	# @question = @parta_category.questions.where(:id => params[:id]).first
    @question = Parta::Question.find_by(id: params[:id])  

    # if @question.nil?
    #   redirect_to login_url, alert: "Not authorised"
    #   return
    # end
    # # for mock exams
    # @exam = Exam.find(params[:exam_id]) if params[:exam_id]

    # if current_user && !@exam

    #   # update user history
    #   if @question.last?(@parta_category)
    #     current_user.update_to_question_id(nil)
    #   else
    #     current_user.update_to_question_id(@question.id)
    #   end

    #   # mark station as complete if question is last
    #   if @question.penultimate?(@parta_category)
    #     attempt = Attempt.where(user_id: current_user.id, station_id: @parta_category.id).first
    #     attempt.update_attribute(:completed, true)
    #   end
    # end
  end

  private

  def parta_question_params
    if params[:action] == "update"
      @question.answers.each do |question_option|
        question_option.update(correct: nil)
        params[:parta_question][:answers_attributes][params[:question][:answers_attributes][:correct]][:correct] = true
      end 
    elsif params[:action] == "create"  
      params[:parta_question][:answers_attributes][params[:question][:answers_attributes][:correct]][:correct] = true
    end  
    params.require(:parta_question).permit(:content, :position, :station_id, :answer_text, :image_text, :image, :answer_image, :parta_category_id, answers_attributes: [:id, :content, :correct, :_destroy])
  end

  def sort_column
    Parta::Question.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
