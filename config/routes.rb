Rails.application.routes.draw do
  get "admin/index"
  get "allocations/create"
  get "users/new"
  get "users/create"
  get "home/index"
  root 'home#index' # We'll create this home page in a second
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  post 'users', to: 'users#create'
end