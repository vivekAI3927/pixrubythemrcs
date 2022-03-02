class Admin::FullTermConditionsController < Admin::BaseController
  before_action :set_admin_access

  def index
   @full_term_conditions = FullTermCondition.all
  end

  def new
    @full_term_condition = FullTermCondition.new
  end

  def show
    @full_term_condition = FullTermCondition.find(params[:id])
  end

  def edit
    @full_term_condition = FullTermCondition.find(params[:id])
  end  

  def create
    @full_term_condition = FullTermCondition.new(privacy_params)
    if @full_term_condition.save
      redirect_to "/admin/full_term_conditions", notice: t('controllers.admin.full_term_conditions.create')  
    else
      render "new"
    end
  end

  def update
    @full_term_condition = FullTermCondition.find(params[:id])
    if @full_term_condition.update_attributes(privacy_params)
      redirect_to "/admin/full_term_conditions", notice: t('controllers.admin.full_term_conditions.update')  
    else
      render "edit"
    end
  end

  private

  def privacy_params
    params.require(:full_term_condition).permit(:title, :description)
  end

end
