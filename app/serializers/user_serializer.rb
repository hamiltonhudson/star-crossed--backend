class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :password, :first_name, :last_name, :birth_year, :birth_month, :birth_day, :gender, :gender_pref, :age, :location, :bio, :photo, :sun, :matches, :date_of_birth

  # attributes :id, :email, :password, :first_name, :last_name, :birth_year, :birth_month, :birth_day, :gender, :gender_pref, :age, :location, :bio, :photo, :sun, :matches, :chats, :active_user

  belongs_to :sun

  # has_many :subscriptions
  # has_many :chats, through: :subscriptions
  # has_many :conversations

  def matches
    object.matches.map do |match|
      ActiveModelSerializers::SerializableResource.new(match, serializer: MatchSerializer)
    end
  end

end
