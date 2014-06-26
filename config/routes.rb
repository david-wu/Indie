Rails.application.routes.draw do
  root "static_pages#index"
  namespace :api do
    resources :events
    resources :users
    resources :perks
    post 'users/login', to: 'users#login'
  end
end
