Rails.application.routes.draw do
  put 'update_link', to: 'video_calls#update'
  get 'join', to: 'coffee#show', as: 'join_coffee'
end
