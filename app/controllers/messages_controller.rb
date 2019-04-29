class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_chatroom_connection, only: [:create]

  def create
    chatroom = Chatroom.find(params[:id])
    message = Message.new(user_id: current_user.id, content: params[:content], chatroom_id: chatroom.id)

    if message.save
      # Send the new message to every client (user's browser) that is subscribed:
      ActionCable.server.broadcast("chatroom_channel_#{chatroom.id}", {message: message, user: message.user})

      # Send a notification to every client (user's browser) that is subscribed and listening for updates:
      ActionCable.server.broadcast("notification_channel_#{chatroom.id}", {message: message})

      # Also update the chatroom connection of every user other than the user that sent the message, changing the new_message attribute to true. This way, the user can log out and come back and they'll still see the "new" message notification:
      chatroom.chatroom_connections.where.not(user_id: current_user.id).update_all(new_message: true)

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
