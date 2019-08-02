class UserChatSerializer < ActiveModel::Serializer
  attributes :id, :chat_id, :sender_id, :receiver_id

end
