Rails.application.routes.draw do
  resources :photoscws, path: :exposure # using carrier wave
  resources :tags
  resources :photos # using active storage
  get 'timeseries', to: 'photos#timeseries'
  get 'timeseries/:id', to: 'photos#timeseries_year'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root to: "home#index"

end
