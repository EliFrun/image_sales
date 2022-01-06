Rails.application.routes.draw do
  resources :image, exclude: [:destroy]
  delete '/image/:image_id', to: 'image#destroy'
  resources :user, exclude: [:destroy]
  delete '/user/:user_id', to: 'user#destroy'
  resources :property, only: [:index]
  get '/property/:name', to: 'property#show'

  post '/transaction', to: 'transaction#sell'
end
