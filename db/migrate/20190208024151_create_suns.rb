class CreateSuns < ActiveRecord::Migration[5.2]
  def change
    create_table :suns do |t|
      t.string :sign
      t.string :start_date
      t.string :end_date
      t.string :compat_signs

      t.timestamps
    end
  end
end
