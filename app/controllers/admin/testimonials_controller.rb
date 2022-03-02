class Admin::TestimonialsController < Admin::BaseController
  before_action :set_admin_access
  def index
   @testimonials = Testimonial.all.where(["author LIKE (?) or content=?","%#{params[:search]}%",params[:search]]).paginate(:page => params[:page], :per_page => 10)
   # @testimonials = Testimonial.all.paginate(:page => params[:page], :per_page => 10)
  end

  def new
    @testimonial = Testimonial.new
  end

  def show
    @testimonial = Testimonial.find_by(id: params[:id])
  end

  def edit
    @testimonial = Testimonial.find_by(id: params[:id])
  end

  def update
    @testimonial = Testimonial.find_by(id: params[:id])
    respond_to do |format|
      if @testimonial.update(testimonial_params)
        format.html { redirect_to @testimonial, notice: t('controllers.admin.testimonials.update') }
        format.json { render :show, status: :ok, location: @testimonial }
      else
        format.html { render :edit }
        format.json { render json: @testimonial.errors, status: :unprocessable_entity }
      end
    end

  end 

  def destroy
    @testimonial = Testimonial.find_by(id: params[:id])
    @testimonial.destroy
    respond_to do |format|
      format.html { redirect_to admin_testimonials_path, notice: t('controllers.admin.testimonials.destroy') }
      format.json { head :no_content }
    end
  end

  def create
    @testimonial = Testimonial.new(testimonial_params)
    if @testimonial.save
      redirect_to admin_testimonials_path, notice: t('controllers.admin.testimonials.create')
    else
      flash[:error] = t('controllers.admin.errors.message')
      render "new"
    end
  end

  def download_pdf
    @testimonial = Testimonial.find_by(id: params[:testimonial_id])
    html = render_to_string(:action => 'download_pdf', :layout => false)
    pdf = PDFKit.new(html)
    send_data(pdf.to_pdf)
  end 

  def get_filter_testimonial
    if params[:author].present?
      author = params[:author]
      @testimonials = Testimonial.all.where("author=?",author)
      @status = true
    elsif params[:content].present? 
        content = params[:content]
        @testimonials = Testimonial.all.where("content=?",content)
        @status = true
    else
      @status = false
    end
  end

  private

  def testimonial_params
    params.require(:testimonial).permit(:author, :content)
  end

end
