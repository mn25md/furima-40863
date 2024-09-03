Rails.application.routes.draw do
  devise_for :users
  get 'items/index'
  resources :users, only: [:show, :edit, :update]
  root to: 'items#index'
end
