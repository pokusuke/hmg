Rails.application.routes.draw do
  devise_for :users

  get 'chat/show'

  root 'events#index'  
 
  resources :users
  resources :areas
  resources :prefs
  resources :events
  resources :event_apps do
    resources :stores
  end

  delete '/logout',to:'sessions#destroy'

  get '/event_msgs',to:'event_msgs#index'
  post '/event_msgs',to:'event_msgs#create'


  get '/event_msg_reps/new',to:'event_msg_reps#new'
  post '/event_msg_reps',to:'event_msg_reps#create'

  get '/msgs/index',to:'msgs#index'
  get '/msgs/select_user',to:'msgs#select_user'
  post '/msgs/select_user',to:'msgs#query_user'

  get '/msgs/:id',to:'msgs#new'
  post 'msgs/:id',to:'msgs#create'

  get '/home',to:'home#index'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end
 
  get '*not_found',to:'application#routing_error'
  post '*not_found',to:'application#routing_error'

  mount ActionCable.server => '/cable'
end
