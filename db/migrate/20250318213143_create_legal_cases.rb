class CreateLegalCases < ActiveRecord::Migration[8.0]
  def change
    create_table :legal_cases do |t|
      t.string :number
      t.string :title
      t.text :description
      t.string :status
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
