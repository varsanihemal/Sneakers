# db/migrate/YYYYMMDDHHMMSS_add_address_to_users.rb
class AddAddressToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :address, :string
    add_column :users, :city, :string
    add_column :users, :postal_code, :string
  end
end
