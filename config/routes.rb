Rails.application.routes.draw do
  devise_for :users
  get '/' => 'chatrooms#show'
  post 'messages' => 'messages#create'
  get '/get_current_user' => 'application#get_current_user'
  mount ActionCable.server, at: '/cable'
end
