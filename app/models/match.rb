class Match < ApplicationRecord
  belongs_to :user
  belongs_to :matched_user, class_name: "User"
  validates_uniqueness_of :matched_user, scope: :user
  # validate :no_duplicate_compatibility
  # after_create :create_inverse_match, unless: :has_inverse_match?

  def decline_match
    # self.has_inverse?
    # self.inverses
    # Declined.create!(user_id: self.user_id, declined_user_id:  self.matched_user_id)
    # self.status = "declined"
  end

  # def create_inverse
  #   self.class.create(inverse_match_options)
  # end
  #
  def has_inverse?
    self.class.exists?(inverse_match_options)
  end

  def inverses
    self.class.where(inverse_match_options)
  end

  # def no_duplicate_compatibility
  #   combinations = ["user_id = #{user_id} AND matched_user_id = #{matched_user_id}", "user_id = #{matched_user_id} AND matched_user_id = #{user_id}"]
  #   if Match.where(combinations.join(' OR ')).exists?
  #     self.errors.add(:user_id, 'Compatibility already exists')
  #   end
  # end

  private

  def inverse_match_options
    { matched_user_id: user_id, user_id: matched_user_id }
  end

end
