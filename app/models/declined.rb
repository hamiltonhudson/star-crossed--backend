class Declined < ApplicationRecord
  belongs_to :user
  has_one :declined_user, class_name: "User"
end
