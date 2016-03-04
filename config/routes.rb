Rails.application.routes.draw do

  devise_for :users

  resources :media,         only: [:index]
  resources :movies,        only: [:index]
  resources :tv_series,     only: [:index]
  resources :subscriptions, only: [:index, :create, :destroy]
  resources :notifications do
    member do
      post :subscribe_via_email
    end
  end

  root to: 'media#index'

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
