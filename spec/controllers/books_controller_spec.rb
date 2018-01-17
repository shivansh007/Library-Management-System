require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  context 'GET index' do
    it 'should return http response ok' do
      get :index
      response.should have_http_status(:ok)
    end
  end

  context 'GET show' do
    it 'should return http response ok' do
      book = create(:book)
      get :show, id: book.id
      response.should have_http_status(:ok)
    end

    it 'should return http response not found if id not found' do
      get :show, id: 0
      response.should have_http_status(:not_found)
    end
  end

  context 'POST create' do
    it 'should return http response ok' do
      book = create(:book)
      post :create, book: { name: book.name, author: book.author, isbn: book.isbn, price: book.price, publication: book.publication, version: book.version, no_of_copies: book.no_of_copies, library_id: book.library_id, category_id: book.category_id }
      response.should have_http_status(:ok)
    end

    it 'should return http response not found if category not found' do
      book = create(:book)
      post :create, book: { name: book.name, author: book.author, isbn: book.isbn, price: book.price, publication: book.publication, version: book.version, no_of_copies: book.no_of_copies, library_id: book.library_id, category_id: 0 }
      response.should have_http_status(:not_found)
    end

    it 'should return http response not found if library not found' do
      book = create(:book)
      post :create, book: { name: book.name, author: book.author, isbn: book.isbn, price: book.price, publication: book.publication, version: book.version, no_of_copies: book.no_of_copies, library_id: 0, category_id: book.category_id }
      response.should have_http_status(:not_found)
    end

    it 'should return http response unprocessable entity for invalid attributes' do
      post :create, book: { name: '', author: '', isbn: '', price: '', publication: '', version: '', no_of_copies: '', library_id: '', category_id: ''  }
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'PUT update' do
    it 'should return http response ok' do
      book = create(:book)
      put :update, id: book.id, book: { name: book.name, author: book.author, isbn: book.isbn, price: book.price, publication: book.publication, version: book.version, no_of_copies: book.no_of_copies, library_id: book.library_id, category_id: book.category_id  }
      response.should have_http_status(:ok)
    end

    it 'should return http response not found if category not found' do
      book = create(:book)
      put :update, book: { name: book.name, author: book.author, isbn: book.isbn, price: book.price, publication: book.publication, version: book.version, no_of_copies: book.no_of_copies, library_id: book.library_id, category_id: 0 }
      response.should have_http_status(:not_found)
    end

    it 'should return http response not found if library not found' do
      book = create(:book)
      put :update, book: { name: book.name, author: book.author, isbn: book.isbn, price: book.price, publication: book.publication, version: book.version, no_of_copies: book.no_of_copies, library_id: 0, category_id: book.category_id }
      response.should have_http_status(:not_found)
    end

    it 'should return http response unprocessable entity for invalid attributes' do
      book = create(:book)
      put :update, id: book.id, book: { name: '', author: '', isbn: '', price: '', publication: '', version: '', no_of_copies: '', library_id: '', category_id: ''  }
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should return http response not found if id not found' do
      put :update, id: 0
      response.should have_http_status(:not_found)
    end
  end

  context 'DELETE' do
    it 'should return http response ok' do
      book = create(:book)
      delete :destroy, id: book.id
      response.should have_http_status(:ok)
    end

    it 'should return http response not found if id not found' do
      delete :destroy, id: 0
      response.should have_http_status(:not_found)
    end
  end
end
