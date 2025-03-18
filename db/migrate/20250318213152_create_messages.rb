class CreateMessages < ActiveRecord::Migration[8.0]
  def change
    create_table :messages do |t|
      t.references :sender, null: false, foreign_key: { to_table: :users } # Aponta para a tabela "users"
      t.references :receiver, null: false, foreign_key: { to_table: :users } # Também aponta para "users"
      t.references :legal_case, null: false, foreign_key: true
      t.text :message
      t.boolean :read, default: false # Adicionei um valor padrão aqui, caso seja útil

      t.timestamps
    end
  end
end
