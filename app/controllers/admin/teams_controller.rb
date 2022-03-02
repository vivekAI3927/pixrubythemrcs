class Admin::TeamsController < Admin::BaseController
  before_action :set_admin_access
  helper_method :sort_column, :sort_direction
 
  def index
    if params[:sort].present?
      @teams =  Team.all.paginate(:page => params[:page], :per_page => 50).order(sort_column + " " + sort_direction)
    else
      @teams = Team.all.where(["name LIKE (?) or title=?","%#{params[:search]}%",params[:search]]).paginate(:page => params[:page], :per_page => 50)
    end
    # if params[:sort].present?
    #   @teams = Team.all.paginate(:page => params[:page], :per_page => 50).reorder(sort_column + " " + sort_direction)
    # else
    #   @teams =  Team.order(:position).paginate(:page => params[:page], :per_page => 50)
    # end 

  end

  def new
    @team = Team.new
  end

  def show
    @team = Team.find_by(id: params[:id])
  end

  def destroy
    @team = Team.find_by(id: params[:id])
    @team.destroy
    respond_to do |format|
      format.html { redirect_to admin_teams_path, notice: t('controllers.admin.teams.destroy') }
      format.json { head :no_content }
    end
  end

  def create
    @team = Team.new(team_params)
    if @team.save
      redirect_to admin_teams_path, notice: t('controllers.admin.teams.create')
    else
      render "new"
    end
  end

  def edit
    @team = Team.find_by(id: params[:id])
  end

  def update
    @team = Team.find_by(id: params[:id])
    if @team.update(team_params)
      redirect_to "/admin/teams/#{@team.id}", notice: t('controllers.admin.teams.update')
    else
      render "edit"
    end
  end 

  private

  def team_params
    params.require(:team).permit(:name, :title, :image, :bio, :position)
  end

  def sort_column
    Team.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
