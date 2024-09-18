Rails.application.routes.draw do
  devise_for :users
  resources :items, only: [:index, :new, :create, :show] do
    resources :orders, only: [:new, :create]
  end
  resources :users, only: [:show, :edit, :update]
  root to: 'items#index'
end
