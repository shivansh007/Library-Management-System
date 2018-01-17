require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  context 'GET index' do
    it 'should return http response ok' do
      get :index
      response.should have_http_status(:ok)
    end
  end

  context 'GET show' do
    it 'should return http response ok' do
      category = create(:category)
      get :show, id: category.id
      response.should have_http_status(:ok)
    end

    it 'should return http response not found if id not found' do
      get :show, id: 0
      response.should have_http_status(:not_found)
    end
  end

  context 'POST create' do
    it 'should return http response ok' do
      category = create(:category)
      post :create, category: { name: category.name }
      response.should have_http_status(:ok)
    end

    it 'should return http response unprocessable entity for invalid attributes' do
      post :create, category: { name: '' }
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'PUT update' do
    it 'should return http response ok' do
      category = create(:category)
      put :update, id: category.id, category: { name: category.name }
      response.should have_http_status(:ok)
    end

    it 'should return http response unprocessable entity for invalid attributes' do
      category = create(:category)
      put :update, id: category.id, category: { name: '' }
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should return http response not found if id not found' do
      put :update, id: 0
      response.should have_http_status(:not_found)
    end
  end

  context 'DELETE' do
    it 'should return http response ok' do
      category = create(:category)
      delete :destroy, id: category.id
      response.should have_http_status(:ok)
    end

    it 'should return http response not found if id not found' do
      delete :destroy, id: 0
      response.should have_http_status(:not_found)
    end
  end
end
