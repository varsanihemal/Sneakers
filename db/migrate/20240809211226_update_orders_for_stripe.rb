class UpdateOrdersForStripe < ActiveRecord::Migration[7.1]
  def up
    # Temporarily add a new column for integer representation
    add_column :orders, :total_amount_cents, :integer, default: 0

    # Convert existing decimal values to integer (cents)
    Order.reset_column_information
    Order.find_each do |order|
      order.update_column(:total_amount_cents, (order.total_amount * 100).to_i)
    end

    # Remove the old decimal column
    remove_column :orders, :total_amount

    # Rename the new column to the original name
    rename_column :orders, :total_amount_cents, :total_amount

    # Ensure the column is of integer type
    change_column :orders, :total_amount, :integer
  end

  def down
    # Reverse migration if needed
    add_column :orders, :total_amount_decimal, :decimal, precision: 10, scale: 2

    Order.reset_column_information
    Order.find_each do |order|
      order.update_column(:total_amount_decimal, order.total_amount / 100.0)
    end

    remove_column :orders, :total_amount
    rename_column :orders, :total_amount_decimal, :total_amount
  end
end
