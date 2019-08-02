class CreateConversations < ActiveRecord::Migration[5.2]
  def change
    create_table :conversations do |t|
      t.string :message
      t.references :chat, foreign_key: true
      t.integer :user_id

      t.timestamps
    end
  end
end
