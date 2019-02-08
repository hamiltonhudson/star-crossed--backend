class SunSerializer < ActiveModel::Serializer
  attributes :id, :sign, :start_date, :end_date, :compat_signs
  has_many :users
  # has_many :users, serializer: UserSerializer
  # has_many :compatibilities
end
