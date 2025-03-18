class CreatePayments < ActiveRecord::Migration[8.0]
  def change
    create_table :payments do |t|
      t.references :invoice, null: false, foreign_key: true
      t.string :payment_method
      t.decimal :value_paid
      t.datetime :payment_date

      t.timestamps
    end
  end
end
