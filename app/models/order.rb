class Order < ApplicationRecord
  belongs_to :user
  belongs_to :province
  has_many :order_items, dependent: :destroy

  validates :address, :city, :postal_code, :province_id, :total_amount, presence: true
  validates :total_amount, numericality: { greater_than_or_equal_to: 0 }
  validates :tax_amount, numericality: { greater_than_or_equal_to: 0 }

  def self.ransackable_attributes(_auth_object = nil)
    ["address", "city", "created_at", "id", "postal_code", "province_id", "status", "tax_amount",
     "total_amount", "updated_at", "user_id"]
  end

  def self.ransackable_associations(_auth_object = nil)
    ["user", "province", "order_items"]
  end

  def subtotal
    Rails.logger.debug "Calculating subtotal..."
    subtotal = order_items.sum { |item| item.price_at_purchase * item.quantity }
    Rails.logger.debug "Subtotal: #{subtotal}"
    subtotal
  end

  def gst
    return 0 unless province&.gst_rate

    subtotal * province.gst_rate
  end

  def pst
    return 0 unless province&.pst_rate

    subtotal * province.pst_rate
  end

  def hst
    return 0 unless province&.hst_rate

    subtotal * province.hst_rate
  end

  def total_amount
    Rails.logger.debug "Calculating total amount..."
    total = subtotal + gst + pst + hst
    Rails.logger.debug "Total Amount: #{total}"
    total
  end
end
