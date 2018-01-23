class CategoriesController < ApplicationController
  protect_from_forgery only: %i[update delete create]

  def index
    @categories = Category.all
    respond_to do |format|
      format.json { render json: { message: 'All categories', categories: @categories }, status: :ok }
      format.html
    end
  end

  def show
    @category = Category.find(params[:id])
    render json: { message: 'category loaded', category: @category }, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'Not found' }, status: :not_found
  end

  def create
    category = Category.create(category_params)
    if category.save
      render json: { message: 'Created category', category: category }, status: :ok
    else
      render json: { message: category.errors }, status: :unprocessable_entity
    end
  end

  def update
    category = Category.find(params[:id])
    if category.update_attributes(category_params)
      render json: { message: 'category updated', category: category }, status: :ok
    else
      render json: { message: category.errors }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'Not found' }, status: :not_found
  end

  def destroy
    category = Category.find(params[:id])
    category.destroy
    render json: { message: 'category deleted', category: nil }, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'Not found' }, status: :not_found
  end

  private

  def category_params
    params.require('category').permit(:name)
  end
end
