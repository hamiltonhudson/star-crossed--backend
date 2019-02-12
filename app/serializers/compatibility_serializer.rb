class CompatibilitySerializer < ActiveModel::Serializer
  attributes :id, :sun_id, :compatible_sun_id
  # belongs_to: sun, serializer: SunSerializer
  # belongs_to: compatible_sun, serializer: SunSerializer
end
