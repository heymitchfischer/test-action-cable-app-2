class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    message = Message.new(user_id: current_user.id, content: params[:content])

    if message.save
      # The below method will send a "broadcast" to all subscribers of the Chatroom Channel. This broadcast's second argument is a hash, or a series of key-value pairs, detailing what data to send to each subscriber. We send the message as well as the user that made the message.

      ActionCable.server.broadcast("chatroom_channel", {message: message, user: message.user})

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
