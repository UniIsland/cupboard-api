Rails.application.routes.draw do
  resources :namespaces, only: [:index]

  resources :metrics, only: [:index]

  namespace :data do
    get :daily
    get :dimension_groups
    get :dimensions
  end
end

# == Route Map
#
#                Prefix Verb URI Pattern                      Controller#Action
#            namespaces GET  /namespaces(.:format)            namespaces#index
#               metrics GET  /metrics(.:format)               metrics#index
#            data_daily GET  /data/daily(.:format)            data#daily
# data_dimension_groups GET  /data/dimension_groups(.:format) data#dimension_groups
#       data_dimensions GET  /data/dimensions(.:format)       data#dimensions
#
