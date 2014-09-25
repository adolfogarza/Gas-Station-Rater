Rails.application.routes.draw do

  resources :ratings

  resources :locations

  resources :comments

  resources :stations

  get 'paginas/principal'

  get "log_out" => "sessions#destroy"
  get "log_in" => "sessions#new"
  get "sign_up" => "users#new"
  root "paginas#principal"
  resources :users
  resources :sessions
  
end