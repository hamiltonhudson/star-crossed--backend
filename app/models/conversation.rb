class Conversation < ApplicationRecord
  belongs_to :chat
  belongs_to :user
  has_one :sender, class_name: "User", foreign_key: 'sender_id'
  has_one :receiver, class_name: "User", foreign_key: 'receiver_id'
  validates_uniqueness_of :receiver, scope: :sender
  
end
