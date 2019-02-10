class AddKeywordsSymbolElementAndVibeToSuns < ActiveRecord::Migration[5.2]
  def change
    add_column :suns, :keywords, :string
    add_column :suns, :symbol, :string
    add_column :suns, :element, :string
    add_column :suns, :vibe, :string
  end
end
