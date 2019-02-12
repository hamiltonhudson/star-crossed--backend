class MatchSerializer < ActiveModel::Serializer
  attributes :id, :status, :matched_user
  # belongs_to :user
  # belongs_to :matched_user, :class_name => "User"

  def matched_user
    user = object.matched_user
    # sun = object.matched_user.sun
    {
      id: user.id,
      first_name: user.first_name,
      last_name: user.last_name,
      birth_year: user.birth_year,
      birth_month: user.birth_month,
      birth_day: user.birth_day,
      gender: user.gender,
      gender_pref: user.gender_pref,
      age: user.age,
      location: user.location,
      bio: user.bio,
      photo: user.photo,
      sun: user.sun
    }

  end

end
