class Product < ApplicationRecord
  # Associations
  has_many :cart_items
  has_many :order_items
  has_many :reviews
  belongs_to :category
  has_many :product_images, dependent: :destroy

  # Instance method to retrieve the first image attachment
  def first_image
    product_images.first&.image
  end

  def self.ransackable_attributes(auth_object = nil)
    ["category_id", "created_at", "description", "id", "name", "price", "stock_quantity", "updated_at"]
  end

  def self.casual_shoes
    category = Category.find_by(name: 'Casual Shoes')
    if category
      where(category_id: category.id)
    else
      none
    end
  end
end
