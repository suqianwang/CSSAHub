Rails.application.routes.draw do
  get 'admin/index'
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
  
  resources :rides	

end
