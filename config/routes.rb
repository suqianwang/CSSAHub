Rails.application.routes.draw do
  root 'home#index'
  get 'home/index'
  
  resources :accounts
  get 'accounts/new'
  
  resources :home
  resources :login
  
  get 'signup', to: 'accounts#new', as: 'signup'
  get 'login', to: 'login#new'
  get 'logout', to: 'login#destroy', as: 'logout'

  get 'logout', to: 'login#logout'
  get 'passenger', to: 'passenger#create'
  get 'driver', to: 'driver#create'

  match 'passenger', to: 'passenger#create2', via: [:post]
  match 'driver', to: 'driver#create2', via: [:post]

  resources :rides	

end
