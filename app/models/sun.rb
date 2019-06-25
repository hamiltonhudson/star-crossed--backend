class Sun < ApplicationRecord
  has_many :users
  has_many :compatibilities, dependent: :destroy
  has_many :compatible_suns, through: :compatibilities
  has_many :inverse_compatibilities, class_name: "Compatibility", foreign_key: "compatible_sun_id"
  has_many :inverse_compatible_suns, through: :inverse_compatibilities, source: :sun, as: :compatible_suns
  after_create :update_pisces, before: :save
  after_create :add_self_compatibility
  after_create :update_vibes, before: :save
  after_create :add_mottos, before: :save
  after_create :add_glyphs, before: :save
  after_create :capitalize_attributes, before: :save

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

  def add_self_compatibility
    @updated_compats = self.compat_signs
    @updated_compats = @updated_compats.split(", ").push(self.sign).join(", ")
    self.compat_signs = @updated_compats
    self.save
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

  def add_mottos
    if self.id == 1
      self.motto = "I am."
      self.save
    elsif self.id == 2
      self.motto = "I have."
      self.save
    elsif self.id == 3
      self.motto = "I think."
      self.save
    elsif self.id == 4
      self.motto = "I feel."
      self.save
    elsif self.id == 5
      self.motto = "I will."
      self.save
    elsif self.id == 6
      self.motto = "I analyze."
      self.save
    elsif self.id == 7
      self.motto = "I balance."
      self.save
    elsif self.id == 8
      self.motto = "I create."
      self.save
    elsif self.id == 9
      self.motto = "I perceive."
      self.save
    elsif self.id == 10
      self.motto = "I use."
      self.save
    elsif self.id == 11
      self.motto = "I know."
      self.save
    elsif self.id == 12
      self.motto = "I believe."
      self.save
    end
  end

  def add_glyphs
    # ♈︎ ♉︎ ♋︎ ♌︎ ♍︎ ♎︎ ♏︎ ♐︎ ♑︎ ♒︎ ♓︎
    if self.id == 1
      self.glyph = " ♈︎"
      self.save
    elsif self.id == 2
      self.glyph = " ♉︎"
      self.save
    elsif self.id == 3
      self.glyph = " ♊︎"
      self.save
    elsif self.id == 4
      self.glyph = " ♋︎"
      self.save
    elsif self.id == 5
      self.glyph = " ♌︎"
      self.save
    elsif self.id == 6
      self.glyph = " ♍︎"
      self.save
    elsif self.id == 7
      self.glyph = " ♎︎"
      self.save
    elsif self.id == 8
      self.glyph = " ♏︎"
      self.save
    elsif self.id == 9
      self.glyph = " ♐︎"
      self.save
    elsif self.id == 10
      self.glyph = " ♑︎"
      self.save
    elsif self.id == 11
      self.glyph = " ♒︎"
      self.save
    elsif self.id == 12
      self.glyph = " ♓︎"
      self.save
    end
  end


  def capitalize_attributes
    self.symbol = self.symbol.split(" ").map(&:capitalize).join(" ")
    self.good_traits = self.good_traits.split.map(&:capitalize).join(" ").split(", ").map{ |trait| trait.gsub(/-[a-xz]/) { |t| t.upcase } }.join(", ")
    self.bad_traits = self.bad_traits.split.map(&:capitalize).join(" ").split(", ").map{ |trait| trait.gsub(/-[a-xz]/) { |t| t.upcase } }.join(", ")
    self.save
  end

end
