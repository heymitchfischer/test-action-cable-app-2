class Chatroom < ApplicationRecord
  has_many :messages
  has_many :chatroom_connections
  has_many :users, through: :chatroom_connections
end
