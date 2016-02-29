Rails.application.routes.draw do
  
  resources :tv_series, only: [:index]
  resources :movies,    only: [:index]

  root to: 'tv_series#index'

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
