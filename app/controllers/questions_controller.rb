class QuestionsController < ApplicationController

  before_action :is_trial_false
  def show
  	@station = Station.friendly.find(params[:station_id])
  	@question = @station.questions.where(:id => params[:id]).first
    
    if current_user
      @station_status = @station.station_status(current_user)
      if @station_status.blank?
        # update default status as 'TO-DO'
        @station_status = @station.update_status(current_user, STATION_TODO)
      end
    end
    if @question.nil?
      redirect_to login_url, alert: t('controllers.questions.not_authorised')
      return
    end
    # for mock exams
    @exam = Exam.find(params[:exam_id]) if params[:exam_id]

    if current_user && !@exam

      # update user history
      if @question.last?(@station)
        current_user.update_to_question_id(nil)
      else
        current_user.update_to_question_id(@question.id)
      end

      # mark station as complete if question is last
      if @question.penultimate?(@station)
        attempt = Attempt.where(user_id: current_user.id, station_id: @station.id).first
        attempt.update_attribute(:completed, true)
      end
    end
  end

end
