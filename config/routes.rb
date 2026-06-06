Rails.application.routes.draw do
  get "home/index"
  root 'home#index' # We'll create this home page in a second
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end