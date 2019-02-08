class Compatibility < ApplicationRecord
  belongs_to :sun
  belongs_to :compatible_sun, class_name: "Sun"
  validates :sun_id, presence: true
  validates :compatible_sun_id, presence: true
  validates_uniqueness_of :compatible_sun, scope: :sun
  validates_uniqueness_of :sun, scope: :compatible_sun_id
  validate :no_duplicate_compatibility

  def no_duplicate_compatibility
    combinations = ["sun_id = #{sun_id} AND compatible_sun_id = #{compatible_sun_id}", "sun_id = #{compatible_sun_id} AND compatible_sun_id = #{sun_id}"]
    if Compatibility.where(combinations.join(' OR ')).exists?
      self.errors.add(:sun_id, 'Compatibility already exists')
    end
  end

end
