class BooksController < ApplicationController
  #  books GET    /books(.:format)     books#index
  def index
    # your code here
    @books = Book.all
  end

  def new
    # your code here
  end

  def create
    # your code here
    @book = Book.new(book_params)
    @book.save
    redirect_to '/books'
  end

  def destroy
    # your code here
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to '/books'
  end

  private
  def book_params
    params.require(:book).permit(:title, :author)
  end
end
