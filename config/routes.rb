Rails.application.routes.draw do
  get 'chat/show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'events#index'  
  #get '/users',to:'users#index'
  #get '/users/new',to:'users#new'
  #post '/users',to:'users#create'
  #get '/users/:id/edit',to:'users#edit'
  resources :users
  resources :areas
  resources :prefs

  get '/login', to:'sessions#new'
  post '/login',to:'sessions#create'
  delete '/logout',to:'sessions#destroy'

  post '/event_apps',to:'event_apps#create'
  get '/event_apps',to:'event_apps#index'

  get '/event_msgs',to:'event_msgs#index'
  post '/event_msgs',to:'event_msgs#create'

  get '/stores',to:'stores#index'
  post '/stores',to:'stores#create'
  get '/stores/new',to:'stores#new'
  post '/stores/store_edit',to:'stores#store_edit'
  get 'stores/show/:id', to:'stores#show'

  get '/event_msg_reps/new',to:'event_msg_reps#new'
  post '/event_msg_reps',to:'event_msg_reps#create'

  get '/msgs/index',to:'msgs#index'
  get '/msgs/select_user',to:'msgs#select_user'
  post '/msgs/select_user',to:'msgs#query_user'

  get '/msgs/:id',to:'msgs#new'
  post 'msgs/:id',to:'msgs#create'

  get '/home',to:'home#index'
 resources :events



end
