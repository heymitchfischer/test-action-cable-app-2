class ChatroomsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_chatroom_connection, only: [:show]

  def index
    @chatrooms = Chatroom.all
  end

  def show
    @chatroom = Chatroom.find(params[:id])
    chatroom_connection = ChatroomConnection.find_by(chatroom_id: @chatroom.id, user_id: current_user.id)
    chatroom_connection.update(new_message: false)
  end
end
