class CreateInvoices < ActiveRecord::Migration[8.0]
  def change
    create_table :invoices do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :value
      t.text :description
      t.string :status
      t.datetime :deadline

      t.timestamps
    end
  end
end
