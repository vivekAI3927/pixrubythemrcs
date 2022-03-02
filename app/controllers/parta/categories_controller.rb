class Parta::CategoriesController < ApplicationController
  before_action :get_categories
  before_action :authenticate_parta_user!

  def index
    if current_user && current_user.last_question_id
      @last_question = Question.find(current_user.last_question_id) rescue nil
      @last_station = @last_question.station rescue nil
    end
    @category = Parta::Category.level_1
    @parta_setting = Parta::Setting.last
    @mock_exam = MockExam.last
  end
  
  def show
    @category = Parta::Category.friendly.find(params[:id])
    @childrens = @category.childrens
    @question = @category.first_question rescue nil
    @questions = @category.questions
    @pos = 1
    if current_parta_user
      @parta_category_status = @category.parta_category_status(current_parta_user)
      if @parta_category_status.blank?
        @parta_category_status = @category.parta_update_status(current_parta_user, 'TO-DO')
      end
    end

  end

  def parta_update_status
    @category = Parta::Category.friendly.find(params[:id])
    @parta_category_status = @category.parta_update_status(current_parta_user, params[:status])
    respond_to do |format|
      format.html { redirect_to request.env['HTTP_REFERER'] }

      format.js
    end
  end

  def parta_cat_update_status
    @category = Parta::Category.friendly.find(params[:id])
    @parta_cat_category_status = @category.parta_cat_update_status(current_parta_user, params[:status])
    respond_to do |format|
      format.html { redirect_to request.env['HTTP_REFERER'] }

      format.js
    end
  end

  private

  def get_categories
    @categories = Parta::Category.level_1
  end
end
