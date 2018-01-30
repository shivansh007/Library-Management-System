Rails.application.routes.draw do
  root 'welcome#index'
  resources :libraries
  resources :books
  resources :members
  resources :categories
  resources :issue_histories
end
