class Match < ApplicationRecord
  belongs_to :user, :dependent => :destroy
  belongs_to :matched_user, class_name: "User"
  # belongs_to :matched_user, class_name: "User", :dependent => :destroy
  validates_uniqueness_of :matched_user, scope: :user
  # validate :no_duplicate_compatibility

  def has_inverse?
    self.class.exists?(inverse_match_options)
  end

  def inverses
    return inverse = self.class.where(inverse_match_options)
  end

  def accept_match
    if self.status == "matched"
      self.inverses.find do |inverse|
        inverse.update_attribute(:status, "awaiting")
        self.update_attribute(:status, "pending")
      end
    elsif self.status == "awaiting"
      self.inverses.find do |inverse|
        inverse.update_attribute(:status, "accepted")
        self.update_attribute(:status, "accepted")
      end
    end
  end


  def decline_match
    self.inverses.find do |inverse|
      inverse.update_attribute(:status, "declined")
    self.update_attribute(:status, "declined")
    end
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
