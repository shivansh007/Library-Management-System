require 'rails_helper'

RSpec.describe MembersController, type: :controller do
  context 'GET index' do
    it 'should return http response ok' do
      get :index
      response.should have_http_status(:ok)
    end
  end

  context 'GET show' do
    it 'should return http response ok' do
      member = create(:member)
      get :show, id: member.id
      response.should have_http_status(:ok)
    end

    it 'should return http response not found if id not found' do
      get :show, id: 0
      response.should have_http_status(:not_found)
    end
  end

  context 'POST create' do
    it 'should return http response ok' do
      member = create(:member)
      post :create, member: { name: member.name, address: member.address, phone: member.phone, is_male: member.is_male, code: member.code, validity_date: member.validity_date, is_author: member.is_author, library_id: member.library_id }
      response.should have_http_status(:ok)
    end

    it 'should return http response not found if library not found' do
      member = create(:member)
      post :create, member: { name: member.name, address: member.address, phone: member.phone, is_male: member.is_male, code: member.code, validity_date: member.validity_date, is_author: member.is_author, library_id: 0 }
      response.should have_http_status(:not_found)
    end

    it 'should return http response unprocessable entity for invalid attributes' do
      post :create, member: { name: '', address: '', phone: '', is_male: '', code: '', version: '', validity_date: '', library_id: '' }
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'PUT update' do
    it 'should return http response ok' do
      member = create(:member)
      put :update, id: member.id, member: { name: member.name, address: member.address, phone: member.phone, is_male: member.is_male, code: member.code, validity_date: member.validity_date, is_author: member.is_author, library_id: member.library_id }
      response.should have_http_status(:ok)
    end

    it 'should return http response not found if library not found' do
      member = create(:member)
      put :update, id: member.id, member: { name: member.name, address: member.address, phone: member.phone, is_male: member.is_male, code: member.code, validity_date: member.validity_date, is_author: member.is_author, library_id: 0 }
      response.should have_http_status(:not_found)
    end

    it 'should return http response unprocessable entity for invalid attributes' do
      member = create(:member)
      put :update, id: member.id, member: { name: '', address: '', phone: '', is_male: '', code: '', version: '', validity_date: '', library_id: '' }
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should return http response not found if id not found' do
      put :update, id: 0
      response.should have_http_status(:not_found)
    end
  end

  context 'DELETE' do
    it 'should return http response ok' do
      member = create(:member)
      delete :destroy, id: member.id
      response.should have_http_status(:ok)
    end

    it 'should return http response not found if id not found' do
      delete :destroy, id: 0
      response.should have_http_status(:not_found)
    end
  end
end
