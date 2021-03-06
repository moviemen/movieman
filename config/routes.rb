Rails.application.routes.draw do

  devise_for :users

  resources :media,         only: [:index, :search]
  resources :movies,        only: [:index]
  resources :tv_series,     only: [:index]
  resources :subscriptions, only: [:index, :create, :destroy]

  match '/search', to: "media#search", via: "get"

  patch 'notifications', to: 'notifications#update'

  root to: 'media#index'

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
