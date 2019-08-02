class User < ApplicationRecord
  belongs_to :sun
  has_many :matches, dependent: :destroy
  has_many :matched_users, through: :matches
  has_many :user_chats
  has_many :chats, through: :user_chats
  has_many :conversations
  validates :email, presence: true, uniqueness: true
  has_secure_password
  validates :password, presence: {on: :create}
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :birth_date, presence: true
  validates :birth_year, presence: true
  validates :birth_month, presence: true
  validates :birth_day, presence: true
  validates :gender, presence: true
  validates :gender_pref, presence: true
  validates :location, presence: true
  validates :bio, presence: true
  validates :photo, presence: true
  before_validation :date_of_birth
  before_validation :get_sun_sign
  before_validation :capitalization
  before_validation :get_age
  after_create :find_matches, before: :save
  after_update :get_sun_sign, before: :save
  after_update :update_matches, before: :save
  after_update :capitalization, before: :save

  def full_name
    "#{self.first_name} #{self.last_name}".scan(/\w+/).each { |x| x.capitalize! }.join(' ')
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
        if self.gender_pref.include?(user.gender) && user.gender_pref.include?(self.gender)
          Match.find_or_create_by(user_id: self.id, matched_user_id: user.id)
          Match.find_or_create_by(user_id: user.id, matched_user_id: self.id)
        end
      end
    end
  end


  def update_matches
    compat_sun_ids = self.sun.compatible_suns.map { |compat_sun| compat_sun.id }
    self.sun.inverse_compatible_suns.map { |ics| compat_sun_ids << ics.id }
    compat_sun_ids.push(self.sun_id)
    User.all.find_all do |user|
      if (compat_sun_ids.include?(user.sun_id)) && (user.id != self.id)
        if self.gender_pref.include?(user.gender) && user.gender_pref.include?(self.gender)
          # unless Match.where(status: "declined").exists?
            Match.find_or_create_by(user_id: self.id, matched_user_id: user.id)
            Match.find_or_create_by(user_id: user.id, matched_user_id: self.id)
            self.check_gender_update
          # end
        end
      end
    end
  end

  def check_gender_update
    self.matches.all.map do |match|
      if !match.matched_user.gender_pref.include?(self.gender) || !self.gender_pref.include?(match.matched_user.gender)
        match.decline_match
        match.save
      end
    end
  end

  def find_accepted
    self.matches.select{ |match| match.status == "accepted"}
  end

  def find_accepted_matched_users
    accepted = self.matches.select{ |match| match.status == "accepted"}
    accepted.map{ |a| a.matched_user }
  end

  def find_pending
    self.matches.select{ |match| match.status == "pending"}
  end

  def find_awaiting
    self.matches.select{ |match| match.status == "awaiting"}
  end

  private
    def date_of_birth
      self.birth_year = self.birth_date.split("-")[0]
      self.birth_month = self.birth_date.split("-")[1]
      self.birth_day = self.birth_date.split("-")[2]
    end

    def get_sun_sign
      Sun.all.find do |sun|
        if self.dob.zodiac_sign == sun.sign
          self.sun = sun
        end
      end
    end


    def get_age
      age_calc = AgeCalculator.new(self.dob)
      self.age = age_calc.age
    end

    def capitalization
      self.first_name = self.first_name.capitalize
      self.last_name = self.last_name.capitalize
      self.gender = self.gender.capitalize
      if self.gender_pref.split.length == 1
        self.gender_pref = self.gender_pref.upcase
      elsif self.gender_pref.split.length > 1
        gp = self.gender_pref.split(",").map{ |pref| pref.strip.upcase }.join(",")
        self.gender_pref = gp
      end
    end


end
