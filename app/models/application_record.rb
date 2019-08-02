class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  alias_attribute :sender_id, :user_id
  alias_attribute :receiver_id, :user_id
  
end
