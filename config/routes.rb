Rails.application.routes.draw do
  devise_for :users

  # Map your existing path names to Devise
  devise_scope :user do
    get '/signup', to: 'devise/registrations#new', as: :signup
    get '/login', to: 'devise/sessions#new', as: :login
    delete '/logout', to: 'devise/sessions#destroy', as: :logout
  end

  # The rest of your routes
  root 'home#index'
  get 'admin', to: 'admin#index', as: :admin_index
  get 'staff/dashboard', to: 'staff_dashboard#index', as: :staff_dashboard
  get 'my_room', to: 'profile#show', as: :my_room

  resources :blocks
  resources :rooms
  resources :allocations, only: [:create, :update]
  resources :tasks, only: [:index, :create, :update, :destroy]
  resources :complaints, only: [:index, :new, :create, :destroy, :update, :show] do
    resources :comments, only: [:create]
  end
end