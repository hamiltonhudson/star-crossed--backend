class Conversation < ApplicationRecord
  belongs_to :chat
  belongs_to :user
  has_one :sender, class_name: "User", foreign_key: 'sender_id'
  has_one :receiver, class_name: "User", foreign_key: 'receiver_id'
  validates_uniqueness_of :receiver, scope: :sender
  # belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'
  # belongs_to :receiver, class_name: 'User', foreign_key: 'receiver_id'
  # validates :sender, uniqueness: {scope: :receiver}

  # belongs_to :sender, class_name: :User, foreign_key: 'sender_id'
  # validates :message, presence: true
  # after_create_commit { MessageBroadcastJob.perform_later(self) }
end
