class Chat < ApplicationRecord
  has_many :conversations
  has_many :user_chats
  has_many :users, through: :user_chats

end
