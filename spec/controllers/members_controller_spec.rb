require 'rails_helper'

RSpec.describe MembersController, type: :controller do
  before(:all) do
    @library = create(:library)
  end

  context 'GET index' do
    it 'should return http response ok' do
      get :index
      response.should have_http_status(:ok)
    end
  end

  context 'GET show' do
    it 'should return http response ok' do
      member = create(:member, library_id: @library.id)
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
      post :create, member: { name: 'Jon Snow', address: 'Winterfell', phone: '9128471243', is_male: true, code: '1234', validity_date: '2019-01-01', is_author: true, library_id: @library.id }
      response.should have_http_status(:ok)
    end

    it 'should return http response not found if library not found' do
      member = create(:member, library_id: @library.id)
      post :create, member: { name: 'Jon Snow', address: 'Winterfell', phone: '9128471243', is_male: true, code: '1234', validity_date: '2019-01-01', is_author: true, library_id: 0 }
      response.should have_http_status(:not_found)
    end

    it 'should return http response unprocessable entity for invalid attributes' do
      member = create(:member, library_id: @library.id)
      post :create, member: { name: '', address: '', phone: '', is_male: '', code: '', version: '', validity_date: '', library_id: @library.id }
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'PUT update' do
    it 'should return http response ok' do
      member = create(:member, library_id: @library.id)
      put :update, id: member.id, member: { name: member.name, address: member.address, phone: member.phone, is_male: member.is_male, code: member.code, validity_date: member.validity_date, is_author: member.is_author, library_id: @library.id }
      response.should have_http_status(:ok)
    end

    it 'should return http response not found if library not found' do
      member = create(:member, library_id: @library.id)
      put :update, id: member.id, member: { name: member.name, address: member.address, phone: member.phone, is_male: member.is_male, code: member.code, validity_date: member.validity_date, is_author: member.is_author, library_id: 0 }
      response.should have_http_status(:not_found)
    end

    it 'should return http response unprocessable entity for invalid attributes' do
      member = create(:member, library_id: @library.id)
      put :update, id: member.id, member: { name: '', address: '', phone: '', is_male: '', code: '', version: '', validity_date: '', library_id: @library.id }
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should return http response not found if id not found' do
      put :update, id: 0
      response.should have_http_status(:not_found)
    end
  end

  context 'DELETE' do
    it 'should return http response ok' do
      member = create(:member, library_id: @library.id)
      delete :destroy, id: member.id
      response.should have_http_status(:ok)
    end

    it 'should return http response not found if id not found' do
      delete :destroy, id: 0
      response.should have_http_status(:not_found)
    end
  end
end
