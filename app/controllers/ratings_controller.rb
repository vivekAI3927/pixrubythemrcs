class RatingsController < ApplicationController
	  before_action :authenticate_user!

	def index
	end

	def new
	end
	
	def create
		@rating = params[:rating][:rating]
		@question = Question.find(params[:rating][:question_id])
		@station_id = params[:rating][:station_id]
		@user_id = params[:rating][:user_id]
		@review = params[:rating][:review]
		if params[:rating][:rating_id].present?
			@update_rating = Rating.find(params[:rating][:rating_id])
			rating_update = @update_rating.update_attributes(rating: params[:rating][:rating], review: params[:rating][:review])
		else
		rating = Rating.create(question_id: @question.id, user_id: @user_id, review: @review, station_id: @station_id)
		end
		if rating_update == true 
			respond_to do |format|
				format.js { render "create"}
			end
		else
			respond_to do |format|
			  if rating.save!
			  	format.js { render "create"}
			  else
			  end
		  end
	  end
	end

end