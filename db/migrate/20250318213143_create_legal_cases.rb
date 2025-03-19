class CreateLegalCases < ActiveRecord::Migration[8.0]
  def change
    create_table :legal_cases do |t|
      t.string :number
      t.string :title
      t.text :description
      t.string :status
      t.references :client, null: false, foreign_key: { to_table: :users } # Aponta para a tabela "users"
      t.references :lawyer, null: false, foreign_key: { to_table: :users } # Também aponta para "users"

      t.timestamps
    end
  end
end
