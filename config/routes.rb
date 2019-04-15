Rails.application.routes.draw do
  root 'home#index'
  get 'home/index'

  resources :accounts do
    collection do
  	  get 'archive'
  	end
  	member do
  	  get :restore
  	end
  end
  patch 'accounts' => 'accounts#destroy'
  
  resources :admin
  get 'admin', to: 'admin#index'
  
  get 'login', to: 'login#index', as: 'login'
  get 'logout', to: 'login#destroy', as: 'logout'
  # Routes for Google authentication
  get 'auth/google_oauth2/callback', to: 'login#create'
  get 'auth/failure', to: redirect('/')

  get 'passenger', to: 'passenger#index'
  get 'driver', to: 'driver#index'

  match 'passenger', to: 'passenger#create', via: [:post]
  match 'driver', to: 'driver#create', via: [:post]

  resources :rides
  get 'rides/:ride_id' => 'rides#contact'
  delete 'rides/:ride_id' => 'rides#destroy'
  resources :services
  
  resources :profile
end
