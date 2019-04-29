class ApplicationController < ActionController::Base
  before_action :authenticate_user!, only: [:get_current_user]

  def get_current_user
    render json: {current_user_id: current_user.id}
  end

  def authenticate_chatroom_connection
    chatroom = Chatroom.find(params[:id])
    if !current_user.chatrooms.include?(chatroom)
      flash[:error] = "Join that chatroom first."
      redirect_to "/"
    end
  end
end
