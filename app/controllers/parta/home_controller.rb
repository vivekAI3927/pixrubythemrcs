class Parta::HomeController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  skip_before_action :is_membership_subscribed?, except: [:index]

  def index
    # initialize variables for home page contents
    @first_testimonial = Testimonial.first
    @testimonials = Testimonial.offset(1)
    @parta_categories = Parta::Category.level_1
    @pricing = Price.all.where(status: true)
    @home_logo_banner = HomeLogoBanner.last
    @all_courses = Course.all.where(available: true)
    @feedbacks = Feedback.where(status: true)
  end    

end
