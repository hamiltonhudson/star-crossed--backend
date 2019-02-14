class Conversation < ApplicationRecord
  belongs_to :chat
  belongs_to :user
  # belongs_to :sender, class_name: :User, foreign_key: 'sender_id'
  # validates :message, presence: true
  # after_create_commit { MessageBroadcastJob.perform_later(self) }
end
