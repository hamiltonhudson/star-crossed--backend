class CreateDeclineds < ActiveRecord::Migration[5.2]
  def change
    create_table :declineds do |t|
      t.references :user, foreign_key: true
      t.references :declined_user

      t.timestamps
    end
    add_foreign_key :declineds, :users, column: :declined_user_id
    add_index :declineds, [:user_id, :declined_user_id], unique: true
  end
end
