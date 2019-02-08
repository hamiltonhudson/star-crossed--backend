class CreateMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :matches do |t|
      t.references :user, foreign_key: true
      t.references :matched_user

      t.timestamps
    end
    add_foreign_key :matches, :users, column: :matched_user_id
    add_index :matches, [:user_id, :matched_user_id], unique: true
  end
end
