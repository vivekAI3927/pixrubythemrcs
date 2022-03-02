class Admin::RecommendsController < Admin::BaseController
	  before_action :authenticate_user!

	def index
	end

	def new
	end
	
	def create
		@name = params[:recommend][:name]
		@email = params[:recommend][:email]
		@description = params[:recommend][:description]
		recommend = Recommend.create(email: @email, description: @description, name: @name)
		# UserMailer.recommend_email(@email, @description).deliver
		UserMailer.delay.recommend_email(@email, @description)
		redirect_to :back, notice: "Email sent to your friend"
	end
    

end