class Subscription < ApplicationRecord
  belongs_to :user
  # has_many :users
  # has_one :user
  belongs_to :chat

  # attributes :sender_id, :receiver_id
  belongs_to :sender, class_name: "User", foreign_key: 'sender_id'
  belongs_to :receiver, class_name: "User", foreign_key: 'receiver_id'
  validates_uniqueness_of :receiver, scope: :sender
  # validates_uniqueness_of :receiver_id, scope: :sender_id

end
