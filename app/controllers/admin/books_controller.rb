class Admin::BooksController < Admin::BaseController
 
  def index
   @books = Book.all.where(["name LIKE (?) or cost=?","%#{params[:search]}%",params[:search]]).paginate(:page => params[:page], :per_page => 10)
  end

  def new
    @book = Book.new
  end

  def destroy
    @book = Book.find_by(id: params[:id])
    @book.destroy
    format.html { redirect_to admin_books_path, notice: t('controllers.admin.books.destroy') }
      format.json { head :no_content }
  end

  def show
    @book = Book.find_by(id: params[:id])
  end

  def edit
    @book = Book.find_by(id: params[:id])
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to admin_books_path, notice: t('controllers.admin.books.create')
    else
      render "new"
    end
  end

  def update
    @book = Book.find_by(id: params[:id])
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to admin_book_path(@book.id), notice: t('controllers.admin.books.update') }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def get_filter_book
    if params[:name].present?
      name = params[:name]
      @books = Book.all.where("name=?",name)
      @status = true
    elsif params[:cost].present? 
      cost = params[:cost]
      @books = Book.all.where("cost=?",cost)
      @status = true
    else
      @status = false
    end
  end
  
  private

  def book_params
    params.require(:book).permit(:name, :description, :link, :cost, :image_file_name, :available)
  end

end
