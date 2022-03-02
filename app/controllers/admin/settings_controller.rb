class Admin::SettingsController < Admin::BaseController

  before_action :set_setting, only: %i[show edit update destroy]

  def index
    @settings =  Setting.all.where(['name LIKE ?', "%#{params[:search]}%"]).paginate(:page => params[:page], :per_page => 10)
  end

  def new
    @setting = Setting.new
  end

  def show
  end

  def create
    @setting = Setting.new(setting_params)
    if @setting.save
      redirect_to admin_settings_path, notice: t('controllers.admin.settings.create')
    else
      render "new"
    end
  end

  def download_pdf
    @setting = Setting.find_by(id: params[:setting_id])
    html = render_to_string(:action => 'download_pdf', :layout => false)
    pdf = PDFKit.new(html)
    send_data(pdf.to_pdf)
  end

  def edit
    @setting
  end

  def update
    respond_to do |format|
      if @setting.update(setting_params)
        format.html { redirect_to admin_setting_path(@setting.id), notice: t('controllers.admin.settings.update') }
        format.json { render :show, status: :ok, location: @setting }
      else
        format.html { render :edit }
        format.json { render json: @setting.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @setting.destroy
    respond_to do |format|
      format.html { redirect_to admin_settings_path, notice: t('controllers.admin.settings.destroy') }
      format.json { head :no_content }
    end
  end

  def get_filter_setting
    if params[:name].present?
      name = params[:name]
      @settings = Setting.all.where("name=?",name)
      @status = true
    elsif params[:price].present? 
        price = params[:price]
        @settings = Setting.all.where("price=?",price)
        @status = true
    else
      @status = false
    end
  end

 
  private

  def set_setting
    @setting = Setting.find(params[:id])
  end

  def setting_params
    params.require(:setting).permit(:name, :price)
  end 
end
