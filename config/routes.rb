Rails.application.routes.draw do
  post 'update_link', to: 'video_calls#update_link'
  get 'join', to: 'coffee#show', as: 'join_coffee'
end
