class SunSerializer < ActiveModel::Serializer
  attributes :id, :sign, :start_date, :end_date, :compat_signs, :keywords, :symbol, :glyph, :element, :vibe, :motto, :good_traits, :bad_traits
  has_many :users
end
