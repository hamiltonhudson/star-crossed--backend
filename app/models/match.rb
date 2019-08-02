class Match < ApplicationRecord
  belongs_to :user
  belongs_to :matched_user, class_name: "User"
  validates_uniqueness_of :matched_user, scope: :user

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
        self.save
      end
    elsif self.status == "awaiting"
      self.inverses.find do |inverse|
        inverse.update_attribute(:status, "accepted")
        self.update_attribute(:status, "accepted")
        self.save
      end
    end
  end


  def decline_match
    self.inverses.find do |inverse|
      inverse.update_attribute(:status, "declined")
    self.update_attribute(:status, "declined")
    self.save
    end
  end

  private
    def inverse_match_options
      { matched_user_id: user_id, user_id: matched_user_id }
    end

end
