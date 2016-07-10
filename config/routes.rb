Rails.application.routes.draw do
  resources :namespaces, only: [:index]

  resources :metrics, only: [:index]

  namespace :data do
    get :daily
    get :dimension_groups
    get :dimensions
  end
end
