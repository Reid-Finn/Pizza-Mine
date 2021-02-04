Rails.application.routes.draw do

  get '/' => 'sessions#welcome'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/signup' => 'users#new'
  post '/signup' => 'users#create'
  delete '/logout' => 'sessions#destroy'
  post '/pizzas/new' => 'pizzas#new'
  get '/auth/:provider/callback' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
  resources :companies
  resources :reviews
  resources :pizzas do
    resources :reviews, only: [:new, :index]
  end
  resources :users
  get '/mypizzas' => 'pizzas#mypizzas'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end