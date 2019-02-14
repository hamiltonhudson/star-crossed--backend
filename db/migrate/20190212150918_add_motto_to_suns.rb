class AddMottoToSuns < ActiveRecord::Migration[5.2]
  def change
    add_column :suns, :motto, :string
  end
end
