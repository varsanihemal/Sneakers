class Product < ApplicationRecord
  # Associations
  has_many :cart_items
  has_many :order_items
  has_many :reviews
  belongs_to :category
  has_many :product_images

  def self.ransackable_associations(auth_object = nil)
    ["category_id", "created_at", "description", "id", "id_value", "name", "price", "stock_quantity", "updated_at"]
  end

  # ActiveStorage for image attachments (if needed)
  has_one_attached :image
end
