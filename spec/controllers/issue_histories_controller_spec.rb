require 'rails_helper'

RSpec.describe IssueHistoriesController, type: :controller do
  context 'GET index' do
    it 'should return http response ok' do
      get :index
      response.should have_http_status(:ok)
    end
  end

  context 'GET show' do
    it 'should return http response ok' do
      issue_history = create(:issue_history)
      get :show, id: issue_history.id
      response.should have_http_status(:ok)
    end

    it 'should return http response not found if id not found' do
      get :show, id: 0
      response.should have_http_status(:not_found)
    end
  end

  context 'POST create' do
    it 'should return http response ok' do
      issue_history = create(:issue_history)
      post :create, issue_history: { issue_type: issue_history.issue_type, issue_date: issue_history.issue_date, return_date: issue_history.return_date, member_id: issue_history.member_id, book_id: issue_history.book_id }
      response.should have_http_status(:ok)
    end

    it 'should return http response not found if member not found' do
      issue_history = create(:issue_history)
      post :create, issue_history: { issue_type: issue_history.issue_type, issue_date: issue_history.issue_date, return_date: issue_history.return_date, member_id: 0, book_id: issue_history.book_id }
      response.should have_http_status(:not_found)
    end

    it 'should return http response not found if book not found' do
      issue_history = create(:issue_history)
      post :create, issue_history: { issue_type: issue_history.issue_type, issue_date: issue_history.issue_date, return_date: issue_history.return_date, member_id: issue_history.member_id, book_id: 0 }
      response.should have_http_status(:not_found)
    end

    it 'should return http response unprocessable entity for invalid attributes' do
      issue_history = create(:issue_history)
      post :create, issue_history: { issue_type: '', issue_date: '', return_date: '', member_id: issue_history.member_id, book_id: issue_history.book_id }
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'PUT update' do
    it 'should return http response ok' do
      issue_history = create(:issue_history)
      put :update, id: issue_history.id, issue_history: { issue_type: issue_history.issue_type, issue_date: issue_history.issue_date, return_date: issue_history.return_date, member_id: issue_history.member_id, book_id: issue_history.book_id }
      response.should have_http_status(:ok)
    end

    it 'should return http response not found if member not found' do
      issue_history = create(:issue_history)
      put :update, id: issue_history.id, issue_history: { issue_type: issue_history.issue_type, issue_date: issue_history.issue_date, return_date: issue_history.return_date, member_id: 0, book_id: issue_history.book_id }
      response.should have_http_status(:not_found)
    end

    it 'should return http response not found if book not found' do
      issue_history = create(:issue_history)
      put :update, id: issue_history.id, issue_history: { issue_type: issue_history.issue_type, issue_date: issue_history.issue_date, return_date: issue_history.return_date, member_id: issue_history.member_id, book_id: 0 }
      response.should have_http_status(:not_found)
    end

    it 'should return http response unprocessable entity for invalid attributes' do
      issue_history = create(:issue_history)
      put :update, id: issue_history.id, issue_history: { issue_type: '', issue_date: '', return_date: '', member_id: issue_history.member_id, book_id: issue_history.book_id }
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should return http response not found if id not found' do
      put :update, id: 0
      response.should have_http_status(:not_found)
    end
  end

  context 'DELETE' do
    it 'should return http response ok' do
      issue_history = create(:issue_history)
      delete :destroy, id: issue_history.id
      response.should have_http_status(:ok)
    end

    it 'should return http response not found if id not found' do
      delete :destroy, id: 0
      response.should have_http_status(:not_found)
    end
  end
end
