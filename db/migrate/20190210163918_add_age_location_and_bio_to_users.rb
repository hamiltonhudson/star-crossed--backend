class AddAgeLocationAndBioToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :age, :integer
    add_column :users, :location, :string
    add_column :users, :bio, :text
  end
end
