class CreateConversations < ActiveRecord::Migration[5.2]
  def change
    create_table :conversations do |t|
      t.string :message
      t.bigint :chat_id, index: true
      t.integer :user_id

      t.timestamps
    end
  end
end
