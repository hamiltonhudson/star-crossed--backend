class User < ApplicationRecord
  belongs_to :sun
  has_many :matches, dependent: :destroy
  has_many :matched_users, through: :matches
  # has_many :subscriptions
  # has_many :chats, through: :subscriptions
  # has_many :conversations
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :birth_year, presence: true
  validates :birth_month, presence: true
  validates :birth_day, presence: true
  validates :gender, presence: true
  validates :gender_pref, presence: true
  # validates :location, presence: true
  # validates :bio, presence: true
  # validates :photo, presence: true
  before_validation :get_sun_sign
  before_validation :capitalization
  before_validation :get_age
  # validates :email, presence: true, :on => :create
  # validates :password, presence: true, length: { minimum: 6, maximum: 12}, :on => :create
  # validates :password, confirmation: true, length: { minimum: 6, maximum: 12}, allow_blank => true, :on => :update
  after_create :find_matches, before: :save
  after_update :find_matches, before: :save
  after_update :get_sun_sign, before: :save
  # after_update :capitalization, before: :save
  # after_update :get_age, before: :save
  # after_validation :find_matches, before: :save



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
        # if self.gender_pref == user.gender && user.gender_pref == self.gender
        if self.gender_pref.include?(user.gender) && user.gender_pref.include?(self.gender)
          unless Match.where(status: "declined").exists?
          Match.find_or_create_by(user_id: self.id, matched_user_id: user.id)
          # Match.find_or_create_by(matched_user_id: self.id, user_id: user.id)
          end
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
        # if self.gender_pref == user.gender && user.gender_pref == self.gender
        if self.gender_pref.include?(user.gender) && user.gender_pref.include?(self.gender)
          # unless Match.where(status: "declined").exists?
            # unless Match.where(status: "accepted").exists?
                Match.find_or_create_by(user_id: self.id, matched_user_id: user.id)
          # Match.find_or_create_by(matched_user_id: self.id, user_id: user.id)
            # end
          # end
        end
      end
    end
  end


  # def check_gender
  #   User.all.find_all do |user|
  #     if self.gender_pref != user.gender && user.gender_pref != self.gender
  #       Match.find_or_create_by(user_id: self.id, matched_user_id: user.id)
  #     end
  #   end
  # end


  # def update_matches
  #   self.matches.destroy
  #   self.find_matches
  # end


  def finds_match(user)
    Match.find_by_user_id(params[:user_id] != user.id)
    Match.find_by_user_id_and_matched_user_id(params[:matched_user_id])
    if user_id == self.id || matched_user_id == self.id
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


  private

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
    self.gender_pref = self.gender_pref.upcase
    location = self.location.split(" ").map {|word| word.capitalize}
    if location.include?(",")
      location[-1].upcase!
      self.location = location.join(" ")
    else self.location = location.join(" ")
    # self.location = self.location.upcase
    self.bio = self.bio.gsub(/([a-z])((?:[^.?!]|\.(?=[a-z]))*)/i) { $1.capitalize + $2.rstrip }
    end
  end



end
