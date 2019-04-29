class ChatroomsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_chatroom_connection, only: [:show]

  def index
    @chatrooms = Chatroom.all
  end

  def show
    @chatroom = Chatroom.find(params[:id])
  end
end
