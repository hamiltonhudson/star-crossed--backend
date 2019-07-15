class ConversationSerializer < ActiveModel::Serializer
  attributes :id, :chat_id, :message, :created_at
  # belongs_to :user
  # belongs_to :user, serializer: UserSerializer
  belongs_to :user, serializer: ConversationUserSerializer
end
