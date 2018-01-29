class LibrariesController < ApplicationController
  protect_from_forgery only: %i[update delete create]

  def index
    @libraries = Library.all
    respond_to do |f|
      f.json {render json: { message: 'All libraries', libraries: @libraries }, status: :ok}
      f.html
    end
    # render json: { message: 'All libraries', libraries: @libraries }, status: :ok
  end

  def show
    @library = Library.find(params[:id])
  #   render json: { message: 'Library loaded', library: @library }, status: :ok
  # rescue ActiveRecord::RecordNotFound
  #   render json: { message: 'Not found' }, status: :not_found
    respond_to do |f|
      f.json { render json: { message: 'Library loaded', library: @library }, status: :ok }
      f.html
    end
    rescue ActiveRecord::RecordNotFound
    respond_to do |f|
      render json: { message: 'Not found' }, status: :not_found
      f.html
    end
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
