class Parta::PracticeAnswersController < ApplicationController

  def index
  end
  
  def show
  end

  def new
  end
  
  def create
    answer_id = params[:parta_question][:answer_id]
    question_id = params[:parta_question][:question_id]
    category_id = params[:parta_question][:category_id]
    @category = Parta::Category.find_by(id: category_id)
    @question = Parta::Question.find_by(id: question_id)
    @answer_option = Parta::PracticeAnswer.new(answer_id: answer_id, question_id: question_id, user_id: current_parta_user.id)
    respond_to do |format|
      @attempt_question = Parta::PracticeAnswer.where(question_id: params[:parta_question][:question_id], user_id: current_parta_user.id)
      if @attempt_question.present?
        @attempt_question
      else  
        @answer_option.save
        format.js {render inline: "location.reload();" }
      end   
    end
  end

  def reset_answer
    question_id = params[:question_id]
    category_id = params[:category_id]
    @answer_id = params[:answers_option_id]
    @category = Parta::Category.find_by(id: category_id)
    @question = Parta::Question.find_by(id: question_id)
    @answer_option = Parta::PracticeAnswer.where(answer_id: @answer_id, question_id: question_id, user_id: current_parta_user.id).last
    if @answer_option.present?
      @answer_option.delete
      redirect_back fallback_location: root_path
    end 
  end

end
