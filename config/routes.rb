Rails.application.routes.draw do
  devise_for :users

  root to: "main#activity"

  resources :events, only: [:create]

  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'
end
