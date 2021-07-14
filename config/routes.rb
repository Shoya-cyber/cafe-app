Rails.application.routes.draw do
  root to: "homes#index"
  get 'posts/new', to: 'posts#new'

end
