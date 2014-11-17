Rails.application.routes.draw do

  resources :comments
  resources :stations
  resources :users
  resources :sessions

  get 'pages/homepage'
  get "log_out" => "sessions#destroy"
  get "log_in" => "sessions#new"
  get "sign_up" => "users#new"
  root "pages#homepage"
  
end