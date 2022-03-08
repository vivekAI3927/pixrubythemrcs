class Admin::RoyalCollegesController < Admin::BaseController
  before_action :set_royal_college, only: %i[show edit update destroy]

  def index
    @royal_colleges = RoyalCollege.all
  end

  def show; end

  def new
    @royal_college = RoyalCollege.new
  end

  def create
    @royal_college = RoyalCollege.new(royal_college_params)
    if @royal_college.save
      redirect_to admin_royal_colleges_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @royal_college.update(royal_college_params)
      redirect_to admin_royal_college_path
    else
      render :edit
    end
  end

  def destroy
    @royal_college.destroy
    redirect_to admin_royal_colleges_path
  end

  private

  def set_royal_college
    @royal_college = RoyalCollege.find_by(id: params[:id])
  end

  def royal_college_params
    params.require(:royal_college).permit(:name)
  end

end
