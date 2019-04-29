class CreateChatroomConnections < ActiveRecord::Migration[5.2]
  def change
    create_table :chatroom_connections do |t|
      t.integer :user_id
      t.integer :chatroom_id

      t.timestamps
    end
  end
end
