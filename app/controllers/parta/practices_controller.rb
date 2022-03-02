class Parta::PracticesController < ApplicationController
  # before_action :get_categories
  before_action :authenticate_parta_user!

  def practice_all
    @question_type = params[:practice_all]
    @category = Parta::Category.friendly.find(params[:category_id])
    @childrens = @category.childrens
    @all_questions_ids = Parta::Question.all.map(&:id)
    active_user_attempts = Parta::AnswersOption.all.where(user_id: current_parta_user.id)
    @all_attempt_question_ids = active_user_attempts.all.map(&:question_id)
    @questions_ids = @all_questions_ids - @all_attempt_question_ids
    if params[:practice_all] == "marked_incorrect"  
      @incorrect_question = []
      @all_attempt_question_ids.each do |attempt_question|
        @question = Parta::Question.find_by(id: attempt_question)
        @correct_answer = @question.answers.where(correct: true).last
        @correct_attempt_question = Parta::AnswersOption.where(question_id: @question.id, answer_id: @correct_answer.id, user_id: current_parta_user.id).last
        if !@correct_attempt_question.present?
          @incorrect_question << @question
        end  
      end
      @shorts_questions = @incorrect_question.sort
      @index_values = @incorrect_question.map(&:id).sort.last(10)
      @question = @shorts_questions.last(10).first
      @question_type = params[:practice_all]
    elsif params[:practice_all] == "new_question"
      @index_values = @questions_ids.sort.last(10)
      @shored_question = @questions_ids.sort
      first_question_id = @shored_question.last(10).first
      @question = Parta::Question.find_by(id: first_question_id) 
      @question_type = params[:practice_all]
    end  
    @user = current_parta_user 
  end


  def practice_all_question
    @question_type = params[:question_type]
    @category = Parta::Category.friendly.find(params[:category_id])
    @question = Parta::Question.find_by(id: params[:question_id])

    @question_ids = Parta::Question.all.map(&:id)

    current_user_attempts = Parta::AnswersOption.all.where(user_id: current_parta_user.id)
    @user_attempt_question_ids = current_user_attempts.all.map(&:question_id)

    @questions_ids = @question_ids - @user_attempt_question_ids

    if @question_type == "marked_incorrect"  
      @collect_incorrect_question = []
      
      @user_attempt_question_ids.each do |attempt_question|
        @active_question = Parta::Question.find_by(id: attempt_question)
        @correct_answer = @active_question.answers.where(correct: true).last
        @correct_attempt_question = Parta::AnswersOption.where(question_id: @active_question.id, answer_id: @correct_answer.id, user_id: current_parta_user.id).last
        if !@correct_attempt_question.present?
          @collect_incorrect_question << @active_question
        end  
      end
      @index_values = @collect_incorrect_question.map(&:id).sort.last(10)
    elsif @question_type == "new_question"
      @index_values = @questions_ids.sort.last(10)  
    end  
  end

  private

  def get_categories
    @categories = Parta::Category.level_1
  end
end
