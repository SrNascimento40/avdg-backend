class AddUniqueIndexToChatsOnUserPair < ActiveRecord::Migration[8.0]
  def change
    add_index :chats, [:user_one_id, :user_two_id], unique: true
  end
end
