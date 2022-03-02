class HomeController < ApplicationController
  before_action :authenticate_user!, except: [:index,:about_us, :trial, :terms, :anatomy, :faq, :about_us, :privacy, :open_resource_modal, :open_course_modal, :community_code, :end_user_license_agreement, :cookie_policies, :disclaimer, :partner, :parta_registration_complete]
  skip_before_action :is_membership_subscribed?, except: [:index, :trial, :terms, :mock_exams, :feedback, :about_us, :privacy, :open_resource_modal, :open_course_modal, :community_code, :end_user_license_agreement, :cookie_policies, :disclaimer, :partner, :parta_registration_complete]
  before_action :only_login_user, only: [:index]

  def index
    # initialize variables for home page contents
    @first_testimonial = Testimonial.first
    @testimonials = Testimonial.offset(1)
    @stations = Station.all.where(trial: true)
    @pricing = Price.all.where(status: true)
    @home_logo_banner = HomeLogoBanner.last
    @all_courses = Course.all.where(available: true)
    @feedbacks = Feedback.where(status: true)
  end

  def about_us
    @about_us = About.last
  end

  def open_resource_modal
    @resource = Resource.find_by(id: params[:id])
    respond_to do |format|
      format.js
    end
  end

  def open_course_modal
    @course = Course.find_by(id: params[:id])
    respond_to do |format|
      format.js
    end
  end

  def faq
  end

  def partner
    @partner = Partner.last
  end

  def courses
    @course = Course.available.first
  end

  def trial
    @trial_stations = Station.trials
  end

  def terms
    @full_term_condition = FullTermCondition.last
  end

  def community_code
    @community_code =  CommunityCode.last
  end

  def end_user_license_agreement
    @eula =  EndUserLicenseAgreement.last
  end

  def privacy
    @privacy_term =  PrivacyTerm.where(status: true).last
  end

  def cookie_policies
    @cookie =  CookiePolicy.last
  end

  def  disclaimer
    @disclaimer =  Disclaimer.last
  end

  def books
    @books = Book.available
  end

  def anatomy
  end

  def mock_exams

  end
  def progress
    @categories = Category.order(:position)
     if current_user && current_user.last_question_id
      @last_question = Question.find(current_user.last_question_id)
      @last_station = @last_question.station
    end
    user_id = current_user.id
  end

  def feedback
    # @feedback = Feedback.where(status: true).last
  end

  def coaching
    @all_courses = Course.all.where(available: true)
  end
	
	#once registered for the parta then it will signout from parta then it will render the registration complete message.
	def parta_registration_complete
		parta_user = PartaUser.where(:id => params[:id]).first
		# sign_out(parta_user)
		@parta_info =  PartaInfo.where(:area_tag => AREA_TAG_PARTA_REGISTRATION_COMPLETE).first
		render :registration_complete
	end
	
  private

  def only_login_user
    if current_user.present?
      redirect_to categories_path, notice: t('controllers.categories.only_login_user')
    end
  end
    

end
