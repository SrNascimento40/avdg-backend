class CreateChangeLogs < ActiveRecord::Migration[8.0]
  def change
    create_table :change_logs do |t|
      t.references :legal_case, null: false, foreign_key: true
      t.text :description
      t.datetime :date

      t.timestamps
    end
  end
end
