Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get 'about', to: 'pages#about'
  get 'all_aboard', to: 'pages#all_aboard'
  resources :users do
    resource :profile
  end
  resources :trips do
    resources :trip_applications do
      get 'accept', to: 'trip_applications#accept'
      get 'deny', to: 'trip_applications#deny'
    end
  end
  resources :boats, :passengers, :logs, :stories
end
