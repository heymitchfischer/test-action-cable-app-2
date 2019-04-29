class AddNewMessageToChatroomConnections < ActiveRecord::Migration[5.2]
  def change
    add_column :chatroom_connections, :new_message, :boolean
  end
end
