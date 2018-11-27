Rails.application.routes.draw do
  get 'join', to: 'coffee#show', as: 'join_coffee'
end
