class CategoriesController < ApplicationController

  before_action :get_categories
  # before_action :authenticate_user!
  before_action :only_login_user, only: [:index, :show]


  def index
    if current_user && current_user.last_question_id
      @last_question = Question.find(current_user.last_question_id) rescue nil
      @last_station = @last_question.station rescue nil
    end
    @member_home_page = MemberHomePage.last
    @mock_exam = MockExam.last
  end

  def show
    @category = Category.friendly.find(params[:id])
    @stations = current_user.stations.available.where(category_id: @category.id)
                                     .includes(:questions).order(:title)
  end

  private

  def get_categories
    @categories = Category.order(:position)
  end

  def only_login_user
    if !current_user.present?
      redirect_to root_path, notice: t('controllers.categories.only_login_user')
    end
  end

end
