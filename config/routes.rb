Rails.application.routes.draw do
  devise_for :users
  resources :items, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
    resources :orders, only: [:new, :create]
  end
  resources :users, only: [:show, :edit, :update]
  root to: 'items#index'
end