class Order < ApplicationRecord
  belongs_to :user
  belongs_to :province
  has_many :order_items

  # Calculate the subtotal of the order
  def subtotal
    order_items.sum { |item| item.price_at_purchase * item.quantity }
  end

  # Calculate GST based on the province's GST rate
  def gst
    subtotal * province.gst_rate
  end

  # Calculate PST based on the province's PST rate
  def pst
    subtotal * province.pst_rate
  end

  # Calculate HST based on the province's HST rate
  def hst
    subtotal * province.hst_rate
  end

  # Calculate the total amount including taxes
  def total_amount
    subtotal + gst + pst + hst
  end
end
