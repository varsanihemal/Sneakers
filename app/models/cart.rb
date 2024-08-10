# app/models/cart.rb
class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  def total_amount
    cart_items.joins(:product).sum("cart_items.quantity * products.price")
  end
end
