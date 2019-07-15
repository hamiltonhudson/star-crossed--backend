class ChatSerializer < ActiveModel::Serializer
  attributes :id, :title
  has_many :conversations
  # has_many :subscriptions
  has_many :users, serializer: ChatUserSerializer
end
