Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get 'about', to: 'pages#about'
  get 'all_aboard', to: 'pages#all_aboard'
  resources :users do
    resource :profile
  end
  resources :trips do
    resources :trip_applications
  end
  resources :boats, :passengers, :logs, :stories
end
