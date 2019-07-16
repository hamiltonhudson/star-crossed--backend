class Chat < ApplicationRecord
  has_many :conversations
  has_many :subscriptions
  has_many :users, through: :subscriptions
  
end
