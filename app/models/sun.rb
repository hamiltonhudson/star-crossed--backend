class Sun < ApplicationRecord
  has_many :users
  has_many :compatibilities, dependent: :destroy
  has_many :compatible_suns, through: :compatibilities
  has_many :inverse_compatibilities, class_name: "Compatibility", foreign_key: "compatible_sun_id"
  has_many :inverse_compatible_suns, through: :inverse_compatibilities, source: :sun, as: :compatible_suns
  after_create :update_pisces, before: :save
  after_create :update_vibes, before: :save

  def find_mutual_compats(sun, arr)
    arr.select do |el|
      self.compat_signs.include?(el)
    end
  end

  private

  def update_pisces
    # self.sign == "Pisces"
    if self.id == 12
      self.compat_signs = ["Taurus", "Cancer", "Scorpio", "Capricorn"]
      self.save
    end
  end

  def update_vibes
    if self.id == 2
      self.vibe = "Determined"
      self.save
    elsif self.id == 3
      self.vibe = "Curious"
      self.save
    elsif self.id == 4
      self.vibe = "Emotional"
      self.save
    elsif self.id == 5
      self.vibe = "Radiant"
      self.save
    elsif self.id == 6
      self.vibe = "Conscientious"
      self.save
    elsif self.id == 7
      self.vibe = "Congenial"
      self.save
    elsif self.id == 9
      self.vibe = "Expressive"
      self.save
    elsif self.id == 10
      self.vibe = "Resilient"
      self.save
    elsif self.id == 11
      self.vibe = "Eccentric"
      self.save
    elsif self.id == 12
      self.vibe = "Sensitive"
      self.save
    end
  end

  def self.add_mottos
    self.first.motto = "I am."
    self.second.motto = "I have."
    self.third.motto = "I think."
    self.fourth.motto = "I feel."
    self.fifth.motto = "I will."
    self.find(6).motto = "I analyze."
    self.find(7).motto = "I balance."
    self.find(8).motto = "I create."
    self.find(9).motto = "I perceive."
    self.find(10).motto = "I use."
    self.find(11).motto = "I know."
    self.find(12).motto = "I believe."
    self.save
  end

end
