Rails.application.routes.draw do
  devise_for :users
  resources :items, only: [:index, :new, :create, :show,]
  resources :users, only: [:show, :edit, :update]
  resources :articles
  root to: 'items#index'
end
