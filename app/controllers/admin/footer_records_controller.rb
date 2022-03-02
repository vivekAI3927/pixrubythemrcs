class Admin::FooterRecordsController < Admin::BaseController
  before_action :set_admin_access
  
  def index
   @footer_records = FooterRecord.all
  end

  def new
    @footer_record = FooterRecord.new
  end

  def show
    @footer_record = FooterRecord.find(params[:id])
  end

  def edit
    @footer_record = FooterRecord.find(params[:id])
  end  

  def create
    @footer_record = FooterRecord.new(privacy_params)
    if @footer_record.save
      redirect_to "/admin/footer_records", notice: t('controllers.admin.footer_records.create')  
    else
      render "new"
    end
  end

  def update
    @footer_record = FooterRecord.find(params[:id])
    if @footer_record.update_attributes(privacy_params)
      redirect_to "/admin/footer_records", notice: t('controllers.admin.footer_records.update')
    else
      render "edit"
    end
  end

  private

  def privacy_params
    params.require(:footer_record).permit(:copyright, :all_right_reserved)
  end

end
