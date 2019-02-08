class CreateCompatibilities < ActiveRecord::Migration[5.2]
  def change
    create_table :compatibilities do |t|
      t.references :sun, foreign_key: true
      t.references :compatible_sun

      t.timestamps
    end
    add_foreign_key :compatibilities, :suns, column: :compatible_sun_id
    add_index :compatibilities, [:sun_id, :compatible_sun_id], unique: true
  end
end
