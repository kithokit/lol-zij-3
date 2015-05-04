Rails.application.routes.draw do
  root "profiles#index"
  get '/profiles/search', to: 'profiles#search'

  resources :profiles


end
