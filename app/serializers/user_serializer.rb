class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name, :last_name, :birth_year, :birth_month, :birth_day, :gender, :gender_pref, :age, :location, :bio, :photo, :sun, :matches, :date_of_birth
  belongs_to :sun
  has_many :user_chats
  has_many :chats, through: :user_chats
  has_many :conversations

  def matches
    object.matches.map do |match|
      ActiveModelSerializers::SerializableResource.new(match, serializer: MatchSerializer)
    end
  end

end
