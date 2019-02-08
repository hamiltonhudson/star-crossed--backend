class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :birth_year, :birth_month, :birth_day, :sun, :matches, :matched_users, :user_matches, :users_matched
  belongs_to :sun
  # belongs_to :sun, serializer: SunSerializer
  has_many :matches
  # has_many :matches, serializer: MatchSerializer
  has_many :matched_users, through: :matches
	# has_many :user_matches, class_name "Match", foreign_key: "matched_user_id" 	has_many :users_matched, through: :user_matches, source :user
end
