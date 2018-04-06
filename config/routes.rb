Rails.application.routes.draw do
  root to: 'home#index'
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/:video_id/', to: 'home#show'
  delete '/logout', to: 'sessions#destroy'
end
