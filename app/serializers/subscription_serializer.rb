class SubscriptionSerializer < ActiveModel::Serializer
  # attributes :id, :user_id, :chat_id
  attributes :id, :chat_id, :sender_id, :receiver_id
end
