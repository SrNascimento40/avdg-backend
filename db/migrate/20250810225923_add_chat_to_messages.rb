class AddChatToMessages < ActiveRecord::Migration[8.0]
  def change
    add_reference :messages, :chat, foreign_key: true
  end
end
