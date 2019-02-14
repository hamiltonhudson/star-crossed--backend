class ChatSerializer < ActiveModel::Serializer
  attributes :id, :title
  has_many :conversations
  has_many :users
  # has_many :users, serializer: UserSerializer
  # has_many :users, serializer:ChatUserSerializer
end
