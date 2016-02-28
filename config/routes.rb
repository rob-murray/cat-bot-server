Rails.application.routes.draw do
  root to: "main#activity"

  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'
end
