class AddBirthDateToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :birth_date, :string
  end
end
