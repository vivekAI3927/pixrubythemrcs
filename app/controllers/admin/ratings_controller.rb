class Admin::RatingsController < Admin::BaseController
  before_action :set_admin_access
  before_action :authenticate_admin!, except: [:index, :get_filter_rating]
  helper_method :sort_column, :sort_direction

	def index
    if params[:sort].present?
      @ratings =  Rating.all.paginate(:page => params[:page], :per_page => 30).order(sort_column + " " + sort_direction)
    elsif params[:search].present?
      @ratings = Rating.all.where(["review=?",params[:search]]).paginate(:page => params[:page], :per_page => 30).order('id DESC')

    else  
		  @ratings = Rating.paginate(:page => params[:page], :per_page => 30)
    end  
	end

	def get_filter_rating
		if params[:question_id].present?
      question_id = params[:question_id]
      @ratings = Rating.all.where("question_id=?",question_id)
      @status = true
    elsif params[:station_id].present? 
        station_id = params[:station_id]
        @ratings = Rating.all.where("station_id =?",station_id)
        @status = true
    else
      @status = false
    end
	end

	def show
		@rating = Rating.find_by(id: params[:id])
	end

	def destroy
   	@rating = Rating.find_by(id: params[:id])
    @rating.destroy
    respond_to do |format|
      format.html { redirect_to admin_ratings_path, notice: t('controllers.admin.ratings.destroy')  }
      format.json { head :no_content }
    end
  end

	def new
		@rating = Rating.new
	end
	
	def create
		@rating = params[:rating][:rating]
		@question = Question.find(params[:rating][:question_id])
		@station_id = params[:rating][:station_id]
		@user_id = params[:rating][:user_id]
		@review = params[:rating][:review]
		user_name = User.find_by(id: @user_id).name
		rating = Rating.new(rating: @rating, question_id: @question.id, user_id: @user_id, review: @review, station_id: @station_id)

		if rating.save
      redirect_to admin_ratings_path, notice: t('controllers.admin.ratings.create')  
    else
      flash[:error] = t('controllers.admin.errors.message')
      render "new"
    end

		# if params[:rating][:rating_id].present?
		# 	@update_rating = Rating.find(params[:rating][:rating_id])
		# 	rating_update = @update_rating.update_attributes(rating: params[:rating][:rating], review: params[:rating][:review])
		# else
		# rating = Rating.create(rating: @rating, question_id: @question.id, user_id: @user_id, review: @review, station_id: @station_id)
		# end
		# if rating_update == true 
		# 	respond_to do |format|
		# 		format.js { render "create"}
		# 	end
		# else
		# 	respond_to do |format|
		# 	  if rating.save!
		# 	  	format.js { render "create"}
		# 	  else
		# 	  end
		#   end
	 #  end
	end

	def edit
   @rating = Rating.find_by(id: params[:id])
  end

  def update
   @rating = Rating.find_by(id: params[:id])
    respond_to do |format|
      if @rating.update(rating_params)
        format.html { redirect_to admin_rating_path(@rating.id), notice: t('controllers.admin.ratings.update') }
        format.json { render :show, status: :ok, location: @rating }
      else
        format.html { render :edit }
        format.json { render json: @rating.errors, status: :unprocessable_entity }
      end
    end
  end

  def download_pdf
    @rating = Rating.find_by(id: params[:rating_id])
    html = render_to_string(:action => 'download_pdf', :layout => false)
    pdf = PDFKit.new(html)
    send_data(pdf.to_pdf)
  end


  private

  def rating_params
    params.require(:rating).permit(:question_id, :station_id, :rating, :review, :user_id)
  end 

  def sort_column
    Rating.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end