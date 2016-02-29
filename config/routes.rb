Rails.application.routes.draw do
  
  resources :media
  
  root to: 'media#index'

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
