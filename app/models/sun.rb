class Sun < ApplicationRecord
  has_many :users
  has_many :compatibilities, dependent: :destroy
  has_many :compatible_suns, through: :compatibilities
  has_many :inverse_compatibilities, class_name: "Compatibility", foreign_key: "compatible_sun_id"
  has_many :inverse_compatible_suns, through: :inverse_compatibilities, source: :sun, as: :compatible_suns
  after_create :update_add_attributes, before: :save
  after_create :capitalize_attributes, before: :save

  def find_mutual_compats(sun, arr)
    arr.select do |el|
      self.compat_signs.include?(el)
    end
  end

  private

  def add_self_compatibility
    @updated_compats = self.compat_signs
    @updated_compats = @updated_compats.split(", ").push(self.sign).join(", ")
    self.compat_signs = @updated_compats
    self.save
  end

  aries_bad_traits = "Proud, Self-Centered, Impulsive, Bossy, Stubborn, Reckless, Jealous"
  aries_bad_traits = aries_bad_traits.split(", ").push("Dogmatic")
  aries_bad_traits.shift
  aries_bad_traits = aries_bad_traits.join(", ")

  def update_add_attributes
    # ♈︎ ♉︎ ♋︎ ♌︎ ♍︎ ♎︎ ♏︎ ♐︎ ♑︎ ♒︎ ♓︎
    if self.id == 1
      self.motto = "I am."
      self.glyph = " ♈︎"
      aries_bad_traits = self.bad_traits.split(", ").push("Dogmatic")
      aries_bad_traits.shift
      self.bad_traits = aries_bad_traits.join(", ")
      self.save
    elsif self.id == 2
      self.vibe = "Determined"
      self.motto = "I have."
      self.glyph = " ♉︎"
      self.save
    elsif self.id == 3
      self.vibe = "Curious"
      self.motto = "I think."
      self.glyph = " ♊︎"
      self.save
    elsif self.id == 4
      self.vibe = "Intuitive"
      self.motto = "I feel."
      self.glyph = " ♋︎"
      self.save
    elsif self.id == 5
      self.vibe = "Radiant"
      self.motto = "I will."
      self.glyph = " ♌︎"
      self.save
    elsif self.id == 6
      self.vibe = "Conscientious"
      self.motto = "I analyze."
      self.glyph = " ♍︎"
      self.save
    elsif self.id == 7
      self.vibe = "Congenial"
      self.motto = "I balance."
      self.glyph = " ♎︎"
      self.save
    elsif self.id == 8
      self.vibe = "Mysterious"
      # self.motto = "I create."
      self.motto = "I challenge."
      self.glyph = " ♏︎"
      self.good_traits = self.good_traits.split(", ").push("Committed").join(", ")
      self.bad_traits = self.bad_traits.split(", ").push("Ruthless").join(", ")
      self.save
    elsif self.id == 9
      self.vibe = "Expressive"
      self.motto = "I perceive."
      self.glyph = " ♐︎"
      self.save
    elsif self.id == 10
      self.vibe = "Resilient"
      self.motto = "I do."
      self.glyph = " ♑︎"
      self.save
    elsif self.id == 11
      # self.vibe = "Eccentric"
      # self.vibe = "Individualistic"
      self.vibe = "Original"
      self.motto = "I know."
      self.glyph = " ♒︎"
      self.save
    elsif self.id == 12
      self.vibe = "Mystical"
      self.motto = "I believe."
      self.glyph = " ♓︎"
      self.compat_signs = "Taurus, Cancer, Scorpio, Capricorn"
      self.good_traits = self.good_traits.split(", ").push("Sensitive").join(", ")
      self.bad_traits = self.bad_traits.split(", ").push("Regressive").join(", ")
      self.save
    end
  end


  def capitalize_attributes
    self.symbol = self.symbol.split(" ").map(&:capitalize).join(" ")
    self.keywords = self.keywords.gsub(/\//, ", ").split.map(&:lstrip).map(&:capitalize).join(" ").split(", ").map{ |trait| trait === "Loyal" ? "Loyalty" : trait.gsub(/-[a-xz]/) { |t| t.upcase } }.join(", ")
    self.good_traits = self.good_traits.split.map(&:capitalize).join(" ").split(", ").map{ |trait| trait.gsub(/-[a-xz]/) { |t| t.upcase } }.join(", ")
    self.bad_traits = self.bad_traits.split.map(&:capitalize).join(" ").split(", ").map{ |trait| trait.gsub(/-[a-xz]/) { |t| t.upcase } }.join(", ")
    self.save
  end

end
