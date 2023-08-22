Rails.application.routes.draw do
  resources :photoscws
  resources :tags
  resources :photos
  get 'home/index'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root to: "home#index"

end
