Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  root to: "homes#index"
  resources :posts
  resources :products, only: [:index, :new, :create, :edit, :update, :destroy]

end
