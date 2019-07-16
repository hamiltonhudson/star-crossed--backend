class ConversationSerializer < ActiveModel::Serializer
  attributes :id, :chat_id, :message, :created_at, :user_name
  belongs_to :user, serializer: ConversationUserSerializer

  def user_name
    "#{object.user.first_name}"
  end

end
