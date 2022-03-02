class StationsController < ApplicationController
	before_action :authenticate_user!, only: :toggle_attempt
	before_action :is_trial_false
	def show
		@station = Station.friendly.find(params[:id])
		@question = @station.first_question rescue nil
		@exam = Exam.find(params[:exam_id]) if params[:exam_id]
    if current_user
			@station_status = @station.station_status(current_user)
			if @station_status.blank?
			  @station_status = @station.update_status(current_user, 'TO-DO')
			end
		end
		if current_user && !@exam
			# mark station as started
			attempt = current_user.attempts.where(station_id: @station.id).first
			attempt.update_attribute(:started, true)

			# add first question to user history
			if @question.present?
				current_user.update_to_question_id(@question.id)
			end	
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

	def update_status
		@station = Station.friendly.find(params[:id])
		@station_status = @station.update_status(current_user, params[:status])
		respond_to do |format|
			format.html { redirect_to request.env['HTTP_REFERER'], notice: t('controllers.stations.update_status') }

			format.js
		end
	end
	
end
