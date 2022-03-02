class Admin::PartnerMembersController < Admin::BaseController
  before_action :set_admin_access

  def index
   @partner_members = PartnerMember.all.paginate(:page => params[:page], :per_page => 50)
  end

  def show
    @partner_member = PartnerMember.find_by(id: params[:id])
  end

  def new
    @partner_member = PartnerMember.new
  end

  def edit
    @partner_member = PartnerMember.find_by(id: params[:id])
  end

  def create
    @partner_member = PartnerMember.new(partner_member_params)
    if @partner_member.save
      redirect_to admin_partner_members_path, notice: t('controllers.admin.partner_members.create')
    else
      render "new"
    end
  end

  def update
     @partner_member = PartnerMember.find_by(id: params[:id])
    if @partner_member.update(partner_member_params)
      redirect_to "/admin/partner_members/#{@partner_member.id}", notice: t('controllers.admin.partner_members.update')  
    else
      flash[:error] = t('controllers.admin.errors.message')
      redirect_to "/admin/partner_members/#{@partner_member.id}/edit"
    end
  end

  def destroy
    @partner_member = PartnerMember.find_by(id: params[:id])
    @partner_member.destroy
    respond_to do |format|
      format.html { redirect_to admin_partner_members_path, notice: t('controllers.admin.partner_members.destroy') }
      format.json { head :no_content }
    end
  end

  private

  def partner_member_params
    params.require(:partner_member).permit(:name, :title, :bio, :image, :position)
  end

end
