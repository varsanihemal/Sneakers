class RemoveStockQuantityFromProducts < ActiveRecord::Migration[7.1]
  def change
    remove_column :products, :stock_quantity, :integer
  end
end
