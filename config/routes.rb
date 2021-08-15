Rails.application.routes.draw do
  
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  root to: "homes#index"
  resources :posts
  resources :products, only: [:index, :new, :create, :edit, :update, :destroy]
  resources :orders, only: [:new, :create, :show]
  resources :users, only: [:show]
  resources :addresses, only: [:edit, :update]

  get 'carts/show', to: 'carts#show', as: 'carts/show'
  post 'carts/add_cart', to: 'carts#add_cart'
  patch 'carts/change_quantity', to: 'carts#change_quantity', as: 'change_item_quantity'
  delete 'carts/destroy_carts_item', to: 'carts#destroy_carts_item', as: 'destroy_carts_item'

  get 'card_address/new', to: 'card_addresses#new', as: 'new_card_address'
  post 'card_address/new', to: 'card_addresses#create'

  get 'orders/complete/:id', to: 'orders#complete', as:'orders_complete'
end
