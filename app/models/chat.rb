class Chat < ApplicationRecord
  has_many :conversations, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :users, through: :subscriptions
  # has_many :users, through: :conversations
  # validate :check_existing

  # validates :sender_id, uniqueness: {scope: :receiver_id}
  # validates :user_id, uniqueness: {scope: :receiver_id, :sender_id}
  # validates :user_id, uniqueness: {scope: :sender_id}

  # validates :user_id, uniqueness: {scope: :receiver_id}

  # validates :user_id, :uniqueness => {:scope => [:sender_id, :receiver_id]}
  # alias_attribute :sender, :user
  # alias_attribute :receiver, :user

  # belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'
  # belongs_to :receiver, class_name: 'User', foreign_key: 'user_id'
  # validates :sender, uniqueness: {scope: :receiver}
  # has_many :conversations, -> { order(created_at: :asc) }, dependent: :destroy

  def check_existing
      if (Chat.where(:sender_id == params["sender_id"] && :receiver_id == params["receiver_id"]).exists? || Chat.where(:sender_id == params["receiver_id"] && :receiver_id == params["sender_id"]).exists?)
      @sender = User.find{|user| user.id == params["sender_id"]}
      @sender.errors.add(:chat, 'already exists')
      render json: @sender.errors.full_messages

      # combinations = [":sender_id == #{params["sender_id"]} AND :receiver_id == #{params["receiver_id"]}", ":sender_id == #{params["receiver_id"]} AND :receiver_id == #{params["sender_id"]}"]
      # if Chat.where(combinations.join(' OR ')).exists?
      #  self.errors.add(:sender_id, 'Compatibility already exists')
      end
    end
end
