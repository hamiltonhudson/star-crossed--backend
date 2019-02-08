class Sun < ApplicationRecord
  has_many :users
  has_many :compatibilities, dependent: :destroy
  has_many :compatible_suns, through: :compatibilities
  has_many :inverse_compatibilities, class_name: "Compatibility", foreign_key: "compatible_sun_id"
  has_many :inverse_compatible_suns, through: :inverse_compatibilities, source: :sun, as: :compatible_suns
  after_create :update_pisces, before: :save

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

end
