class ChatroomConnectionsController < ApplicationController
  before_action :authenticate_user!

  def create
    chatroom_connection = ChatroomConnection.create(user_id: current_user.id, chatroom_id: params[:id])

    redirect_to "/chatrooms/#{chatroom_connection.chatroom_id}"
  end
end
