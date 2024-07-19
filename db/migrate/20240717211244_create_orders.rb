class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :total_amount
      t.decimal :tax_amount, precision: 10, scale: 2 # Add tax_amount here
      t.string :status

      t.timestamps
    end
  end
end
