class ChatSerializer < ActiveModel::Serializer
  attributes :id, :title, :user_ids
  has_many :conversations
  has_many :users, serializer: ChatUserSerializer

  def user_ids
    object.users.map{|user| user.id}
  end

end
