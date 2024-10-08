class Order < ApplicationRecord
  belongs_to :user
  belongs_to :province
  has_many :order_items, dependent: :destroy

  validates :address, :city, :postal_code, :province_id, :total_amount, presence: true

  # Specify which attributes are searchable
  def self.ransackable_attributes(_auth_object = nil)
    ["address", "city", "created_at", "id", "postal_code", "province_id", "status", "tax_amount",
     "total_amount", "updated_at", "user_id"]
  end

  # Specify which associations are searchable
  def self.ransackable_associations(_auth_object = nil)
    ["user", "province", "order_items"] # List the associations that you want to be searchable
  end

  # Calculate the subtotal of the order
  def subtotal
    Rails.logger.debug "Calculating subtotal..."
    subtotal = order_items.sum { |item| item.price_at_purchase * item.quantity }
    Rails.logger.debug "Subtotal: #{subtotal}"
    subtotal
  end

  # Calculate GST based on the province's GST rate
  def gst
    return 0 unless province&.gst_rate

    subtotal * province.gst_rate
  end

  # Calculate PST based on the province's PST rate
  def pst
    return 0 unless province&.pst_rate

    subtotal * province.pst_rate
  end

  # Calculate HST based on the province's HST rate
  def hst
    return 0 unless province&.hst_rate

    subtotal * province.hst_rate
  end

  # Calculate the total amount including taxes
  def total_amount
    Rails.logger.debug "Calculating total amount..."
    total = subtotal + gst + pst + hst
    Rails.logger.debug "Total Amount: #{total}"
    total
  end
end
