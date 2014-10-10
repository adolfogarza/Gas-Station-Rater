Rails.application.routes.draw do

  resources :ratings
  resources :locations
  resources :comments
  resources :stations
  resources :users
  resources :sessions
  get 'paginas/principal'
  get "log_out" => "sessions#destroy"
  get "log_in" => "sessions#new"
  get "sign_up" => "users#new"
  root "paginas#principal"
  
end