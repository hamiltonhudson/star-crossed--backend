class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :birth_year, :birth_month, :birth_day, :gender, :gender_pref, :age, :location, :bio, :photo, :sun, :matches
  belongs_to :sun

  def matches
    object.matches.map do |match|
      ActiveModelSerializers::SerializableResource.new(match, serializer: MatchSerializer)
    end
  end

end
