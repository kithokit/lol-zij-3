Rails.application.routes.draw do
  root "profiles#index"
  resources :profiles
end
