class CreateMessages < ActiveRecord::Migration[8.0]
  def change
    create_table :messages do |t|
      t.references :sender, null: false, foreign_key: { to_table: :users }
      t.references :receiver, null: false, foreign_key: { to_table: :users }
      t.references :legal_case, null: false, foreign_key: true
      t.text :content, null: false
      t.boolean :read, default: false 

      t.timestamps
    end
  end
end
