Rails.application.routes.draw do
  resources :libraries
  resources :books
  resources :members
  resources :categories
  resources :issue_histories
end
