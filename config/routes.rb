Rails.application.routes.draw do

  devise_for :users

  resources :media,         only: [:index]
  resources :movies,        only: [:index]
  resources :tv_series,     only: [:index]
  resources :subscriptions, only: [:index, :create, :destroy]

  root to: 'media#index'

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
