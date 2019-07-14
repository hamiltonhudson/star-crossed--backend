class RemoveChatIdFromConversations < ActiveRecord::Migration[5.2]
  def change
    remove_column :conversations, :chat_id, :integer
  end
end
