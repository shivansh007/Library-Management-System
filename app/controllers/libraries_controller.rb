class LibrariesController < ApplicationController
  protect_from_forgery only: %i[update delete create]

  def index
    @libraries = Library.all
    render json: { message: 'All libraries', libraries: @libraries }, status: :ok
  end

  def show
    @library = Library.find(params[:id])
    render json: { message: 'Library loaded', library: @library }, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'Not found' }, status: :not_found
end

def create
  library = Library.create(library_params)
  if library.save
    render json: { message: 'Created Library', library: library }, status: :ok
  else
    render json: { message: library.errors }, status: :unprocessable_entity
  end
end

def update
  library = Library.find(params[:id])
  if library.update_attributes(library_params)
    render json: { message: 'Library updated', library: library }, status: :ok
  else
    render json: { message: library.errors }, status: :unprocessable_entity
  end
rescue ActiveRecord::RecordNotFound
  render json: { message: 'Not found' }, status: :not_found
end

def destroy
  library = Library.find(params[:id])
  library.destroy
  render json: { message: 'Library deleted', library: nil }, status: :ok
rescue ActiveRecord::RecordNotFound
  render json: { message: 'Not found' }, status: :not_found
end

private

def library_params
  params.require('library').permit(:name, :address, :phone)
end
end
