class Chat < ApplicationRecord
  has_many :conversations
  has_many :subscriptions
  has_many :users, through: :subscriptions

  # belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'
  # belongs_to :receiver, class_name: 'User', foreign_key: 'user_id'
  # validates :sender, uniqueness: {scope: :receiver}
  # has_many :conversations, -> { order(created_at: :asc) }, dependent: :destroy
end
