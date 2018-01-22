require 'rails_helper'

RSpec.describe LibrariesController, type: :controller do
  context 'GET index' do
    it 'should return http response ok' do
      get :index
      response.should have_http_status(:ok)
    end
  end

  context 'GET show' do
    it 'should return http response ok' do
      library = create(:library)
      get :show, id: library.id
      response.should have_http_status(:ok)
    end

    it 'should return http response not found if id not found' do
      get :show, id: 0
      response.should have_http_status(:not_found)
    end
  end

  context 'POST create' do
    it 'should return http response ok' do
      post :create, library: { name: 'Saraswati Library', address: 'Gulab Bagh, Udaipur', phone: '9523523519' }
      response.should have_http_status(:ok)
    end

    it 'should return http response unprocessable entity for invalid attributes' do
      post :create, library: { name: '', address: '', phone: '' }
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'PUT update' do
    it 'should return http response ok' do
      library = create(:library)
      put :update, id: library.id, library: { name: library.name, address: library.address, phone: library.phone }
      response.should have_http_status(:ok)
    end

    it 'should return http response unprocessable entity for invalid attributes' do
      library = create(:library)
      put :update, id: library.id, library: { name: '', address: '', phone: '' }
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should return http response not found if id not found' do
      put :update, id: 0
      response.should have_http_status(:not_found)
    end
  end

  context 'DELETE' do
    it 'should return http response ok' do
      library = create(:library)
      delete :destroy, id: library.id
      response.should have_http_status(:ok)
    end

    it 'should return http response not found if id not found' do
      delete :destroy, id: 0
      response.should have_http_status(:not_found)
    end
  end
end
