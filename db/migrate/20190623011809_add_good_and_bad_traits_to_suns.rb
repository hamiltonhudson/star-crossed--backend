class AddGoodAndBadTraitsToSuns < ActiveRecord::Migration[5.2]
  def change
    add_column :suns, :good_traits, :string
    add_column :suns, :bad_traits, :string
  end
end
