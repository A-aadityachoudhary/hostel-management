Rails.application.routes.draw do
  get "staff_dashboard/index"
  get "profile/show"
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
  resources :allocations, only: [:create, :update]
  get 'my_room', to: 'profile#show'
  get 'staff/dashboard', to: 'staff_dashboard#index', as: :staff_dashboard
  # config/routes.rb
  resources :tasks, only: [:index, :create, :update, :destroy]
end