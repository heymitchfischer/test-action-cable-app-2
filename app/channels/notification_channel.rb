class NotificationChannel < ApplicationCable::Channel
  def subscribed
    stream_from "notification_channel_#{params[:chatroom_id]}"
  end
end
