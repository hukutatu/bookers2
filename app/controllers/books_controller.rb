class BooksController < ApplicationController
  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

  def show
  @book = Book.find(params[:id])
  @user = @book.user
  @newbook = Book.new

  end

  def edit
    @book = Book.find(params[:id])
    unless  @book.user_id == current_user.id
      redirect_to books_path
    end
  end

  def create
    @user = current_user
    @book = Book.new(book_params)
    @book.user_id = current_user.id
   if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
   else
      @books = Book.all
      render :index
   end
  end

  def update
   @book = Book.find(params[:id])
   if @book.update(book_params)
      flash[:notice] = "You have updated user successfully.."
       redirect_to book_path(@book.id)
   else
       render :edit
   end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to '/books'
  end

   private
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
