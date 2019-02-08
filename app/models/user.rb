class User < ApplicationRecord
  belongs_to :sun
  has_many :matches, dependent: :destroy
  has_many :matched_users, through: :matches
  has_many :user_matches, class_name: "Match", foreign_key: "matched_user_id"
  has_many :users_matched, through: :user_matches, source: :user
  before_validation :get_sun_sign
  before_validation :capitalize_name
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :birth_year, presence: true
  validates :birth_month, presence: true
  validates :birth_day, presence: true
  after_create :find_matches
  # before_save :find_matches, on: :create
  # after_validation :find_matches, on: :create
  after_create :find_matches, before: :save


  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def capitalize_name
    # [first_name, last_name].map(&:capitalize)
    return [self.first_name, self.last_name].map(&:capitalize)
    # return [first_name: self.first_name.capitalize, last_name: self.last_name.capitalize]

  end

  def dob
    bday = Date.new(("#{self.birth_year}").to_i, ("#{self.birth_month}").to_i, ("#{self.birth_day}").to_i)
  end

  def find_matches
    compat_sun_ids = self.sun.compatible_suns.map { |compat_sun| compat_sun.id }
    self.sun.inverse_compatible_suns.map { |ics| compat_sun_ids << ics.id }
    compat_sun_ids.push(self.sun_id)
    User.all.find_all do |user|
      if (compat_sun_ids.include?(user.sun_id)) && (user.id != self.id)
        Match.find_or_create_by(user_id: self.id, matched_user_id: user.id)
        # Match.find_or_create_by(matched_user_id: self.id, user_id: user.id)
      end
    end
  end

  # def find_matches_without_duplication
  #   compat_sun_ids = self.sun.compatible_suns.map { |compat_sun| compat_sun.id }
  #   self.sun.inverse_compatible_suns.map { |ics| compat_sun_ids << ics.id }
  #   compat_sun_ids.push(self.sun_id)
  #   User.all.find_all do |user|
  #     if (compat_sun_ids.include?(user.sun_id)) && (user.id != self.id)
  #       unless Match.where(matched_user_id: self.id, user_id: user.id).exists?
  #         Match.find_or_create_by(user_id: self.id, matched_user_id: user.id)
  #       end
  #     end
  #   end
  # end

  def finds_match(user)
    Match.find_by_user_id(params[:user_id] != user.id)
    Match.find_by_user_id_and_matched_user_id(params[:matched_user_id])
    if user_id == self.id || matched_user_id == self.id
    end
  end

  private

  def get_sun_sign
    Sun.all.find do |sun|
      if self.dob.zodiac_sign == sun.sign
        self.sun = sun
      end
    end
  end

end
