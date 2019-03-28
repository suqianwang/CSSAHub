Rails.application.routes.draw do
  root 'home#index'
  get 'home/index'
  
  resources :accounts
  get 'accounts/new'
  
  resources :admin
  get 'admin', to: 'admin#index'
  
  resources :home
  resources :login
  
  get 'signup', to: 'accounts#new', as: 'signup'
  get 'login', to: 'login#new'
  get 'logout', to: 'login#destroy', as: 'logout'

  get 'logout', to: 'login#logout'

  get 'passenger', to: 'passenger#index'
  get 'driver', to: 'driver#index'

  match 'passenger', to: 'passenger#create', via: [:post]
  match 'driver', to: 'driver#create', via: [:post]

  resources :rides
  delete 'rides/:ride_id' => 'rides#destroy'
  resources :services
  
  resources :profile
end
