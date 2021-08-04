Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  root to: "homes#index"
  resources :posts
  resources :products, only: [:index, :new, :create, :edit, :update, :destroy]

  get 'carts/show', to: 'carts#show', as: 'carts/show'
  post 'carts/add_cart', to: 'carts#add_cart'
end
