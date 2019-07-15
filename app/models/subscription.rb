class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :chat

  # attributes :sender_id, :receiver_id
  has_one :sender, class_name: "User", foreign_key: 'sender_id'
  has_one :receiver, class_name: "User", foreign_key: 'receiver_id'
  validates_uniqueness_of :receiver, scope: :sender
  # validates_uniqueness_of :receiver_id, scope: :sender_id
  #
  # def no_duplicate_compatibility
  #   combinations = ["sender_id = #{sender_id} AND receiver_id = #{receiver_id}", "sender_id = #{receiver_id} AND receiver_id = #{sender_id}"]
  #   if Subscription.where(combinations.join(' OR ')).exists?
  #     self.errors.add(:sender_id, 'Subscription already exists')
  #   end
  # end

end
