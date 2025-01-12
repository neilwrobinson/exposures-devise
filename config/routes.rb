require "sidekiq/web" # Brings in the Sidekiq Web UI

Rails.application.routes.draw do
  resources :photoscws, path: :exposure # using carrier wave
  resources :tags, only: [:index, :show ]
  resources :photos # using active storage
  get 'timeseries', to: 'photos#timeseries'
  get 'timeseries/:id', to: 'photos#timeseries_year'
  get 'upload-pictures', to: 'photos#batch_upload'
  post 'upload-pictures', to: 'photos#batch_upload_create'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root to: "home#index"


  # make the Sidekiq web UI available on /sidekiq
  # TODO: update before launch into production 
  mount Sidekiq:: Web => "/sidekiq"

end
