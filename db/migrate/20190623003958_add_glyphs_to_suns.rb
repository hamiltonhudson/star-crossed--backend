class AddGlyphsToSuns < ActiveRecord::Migration[5.2]
  def change
    add_column :suns, :glyph, :string
  end
end
