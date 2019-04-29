class ChatroomChannel < ApplicationCable::Channel
  def subscribed
    # The "assets/javascripts/channels/chatroom.js" file will subscribe to the chatroom channel. This method tells the Chatroom Channel what to do when a client subscribes. In this case, we're telling the Chatroom Channel subscription to listen for any updates or "broadcasts" from the Channel.
    stream_from("chatroom_channel")
  end
end
