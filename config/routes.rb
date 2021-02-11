Rails.application.routes.draw do


  
  
  resources :genres
  resources :users
  get "signup" => "users#new"
  #root route that maps to the index action for the MoviesController
  get "movies/filter/:filter" => "movies#index", as: :filtered_movies
 root "movies#index"

 resource :session, only: [:new, :create, :destroy]
 get "signin" => "sessions#new"
 
 resources :movies do
 	resources :reviews
 	resources :favorites, only: [:create, :destroy]
 end
 
end
