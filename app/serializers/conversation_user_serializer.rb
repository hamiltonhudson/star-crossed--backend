class ConversationUserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :sun_sign

  def sun_sign
    "#{object.sun.sign}"
  end

end
