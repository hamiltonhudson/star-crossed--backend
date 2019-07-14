class AddChatReferenceToConversations < ActiveRecord::Migration[5.2]
  def change
    add_reference :conversations, :chat, foreign_key: true
  end
end
