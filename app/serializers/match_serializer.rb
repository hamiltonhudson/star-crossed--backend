class MatchSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :matched_user_id
  # has_one: / belongs_to: :user
  # has_one: / belongs_to: :matched_user, :class_name => "User"
end
