class SubscriptionSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :chat_id
end
