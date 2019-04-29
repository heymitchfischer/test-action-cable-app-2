Rails.application.routes.draw do
  devise_for :users
  get '/' => 'chatrooms#index'
  get '/chatrooms' => 'chatrooms#index'
  get '/chatrooms/:id' => 'chatrooms#show'
  post '/chatrooms/:id/messages' => 'messages#create'
  get '/get_current_user' => 'messages#get_current_user'
  post '/chatrooms/:id/chatroom_connections' =>  'chatroom_connections#create'
  mount ActionCable.server, at: '/cable'
end
