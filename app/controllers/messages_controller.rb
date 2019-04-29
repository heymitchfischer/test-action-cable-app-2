class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_chatroom_connection, only: [:create]

  def create
    chatroom = Chatroom.find(params[:id])
    message = Message.new(user_id: current_user.id, content: params[:content], chatroom_id: chatroom.id)

    if message.save
      ActionCable.server.broadcast("chatroom_channel_#{chatroom.id}", {message: message, user: message.user})

      respond_to do |format|
        format.json {render json: {status: 204}}
        format.html do
          flash[:success] = "You sent a message!"
          redirect_to "/"
        end
      end
    else
      respond_to do |format|
        format.json {render json: {status: 400}}
        format.html do
          flash[:error] = "Something went wrong!"
          redirect_to "/"
        end
      end
    end
  end
end
