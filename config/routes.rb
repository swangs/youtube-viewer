Rails.application.routes.draw do
  root to: 'video#index'
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/:video_id/', to: 'video#show'
  get '/messages/:chat_id', to: 'messages#index'
  get '/messages/search/:query', to: 'messages#search'
  delete '/logout', to: 'sessions#destroy'
  match '*path' => redirect('/'), via: :get
end
