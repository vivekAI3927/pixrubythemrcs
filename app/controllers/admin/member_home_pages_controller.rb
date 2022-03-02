class Admin::MemberHomePagesController < Admin::BaseController
  before_action :set_admin_access

  def index
   @member_home_pages =  MemberHomePage.all.paginate(:page => params[:page], :per_page => 10)
  end

  def new
    @member_home_page = MemberHomePage.new
  end

  def destroy
    @member_home_page = MemberHomePage.find_by(id: params[:id])
    @member_home_page.destroy
    respond_to do |format|
      format.html { redirect_to admin_member_home_pages_path, notice: t('controllers.admin.member_home_pages.destroy') }
      format.json { head :no_content }
    end
  end

  def show
    @member_home_page = MemberHomePage.find_by(id: params[:id])
  end

  def edit
    @member_home_page = MemberHomePage.find_by(id: params[:id])
  end

  def create
    @member_home_page = MemberHomePage.new(member_home_page_params)
    if @member_home_page.save
      redirect_to "/admin/member_home_pages", notice: t('controllers.admin.member_home_pages.create')  
    else
      render "new"
    end
  end

  def update
     @member_home_page = MemberHomePage.find_by(id: params[:id])
    if @member_home_page.update(member_home_page_params)
      redirect_to "/admin/member_home_pages", notice: t('controllers.admin.member_home_pages.update')
    else
      render "edit"
    end
  end

  private

  def member_home_page_params
    params.require(:member_home_page).permit(:title, :description)
  end

end
