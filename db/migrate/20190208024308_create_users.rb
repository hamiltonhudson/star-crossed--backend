class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :birth_year
      t.string :birth_month
      t.string :birth_day
      t.references :sun, foreign_key: true

      t.timestamps
    end
  end
end
