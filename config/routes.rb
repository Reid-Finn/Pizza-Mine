Rails.application.routes.draw do

  get '/' => 'sessions#welcome'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/signup' => 'users#new'
  post '/signup' => 'users#create'
  delete '/logout' => 'sessions#destroy'
  get 'logout' => 'sessions#destroy'
  get '/auth/:provider/callback' => 'sessions#omniauth'
  #get '/auth/:google_oauth2' => 'sessions#omniauth'
  
  
  resources :companies
  resources :reviews
  resources :pizzas do
    resources :reviews, only: [:new, :index]
  end

  resources :users do
    resources :reviews, only:[:index]
  end
    
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end