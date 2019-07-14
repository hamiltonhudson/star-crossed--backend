class ChatUserSerializer < ActiveModel::Serializer
  # include Rails.application.routes.url_helpers
  attributes :id, :first_name
  # attributes :id, :email, :password, :first_name, :sun, :matches
  # attributes :id, :first_name, :sun, :active_user
  # alias_attribute :id, :sender_id
end
