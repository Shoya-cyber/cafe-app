Rails.application.routes.draw do
  root to: "homes#index"
  resources :posts, only: [:index, :new, :create]

end
