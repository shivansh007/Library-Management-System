class BooksController < ApplicationController
  protect_from_forgery only: %i[update delete create]

  def index
    @books = Book.all
    render json: { message: 'All books', books: @books }, status: :ok
  end

  def show
    @book = Book.find(params[:id])
    render json: { message: 'Book loaded', book: @book }, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'Not found' }, status: :not_found
  end

  def create
    Library.find(book_params[:library_id])
    Category.find(book_params[:category_id])
    book = Book.create(book_params)
    if book.save
      render json: { message: 'Created book', book: book }, status: :ok
    else
      render json: { message: book.errors }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'Not found' }, status: :not_found
  end

  def update
    book = Book.find(params[:id])
    Library.find(book_params[:library_id])
    Category.find(book_params[:category_id])
    if book.update_attributes(book_params)
      render json: { message: 'Book updated', book: book }, status: :ok
    else
      render json: { message: book.errors }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'Not found' }, status: :not_found
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    render json: { message: 'Book deleted', book: nil }, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'Not found' }, status: :not_found
  end

  private

  def book_params
    params.require('book').permit(:name, :author, :isbn, :price, :publication, :version, :no_of_copies, :library_id, :category_id)
  end
end
