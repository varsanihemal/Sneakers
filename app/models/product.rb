class Product < ApplicationRecord
  # Associations
  has_many :cart_items
  has_many :order_items
  has_many :reviews
  belongs_to :category
  has_many :product_images, dependent: :destroy

  # Validations
  validates :name, presence: true
  validates :price, numericality: { greater_than: 0 }
  validates :stock_quantity, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  # Instance method to retrieve the first image attachment
  def first_image
    product_images.first&.image
  end

  # Ransackable attributes for search functionality
  def self.ransackable_attributes(auth_object = nil)
    ["category_id", "created_at", "description", "id", "name", "price", "stock_quantity", "updated_at"]
  end

  # Scopes for filtering products
  scope :casual_shoes, -> {
    category = Category.find_by(name: 'Casual Shoes')
    where(category_id: category.id) if category
  }

  # General scope for filtering by category name
  scope :by_category, -> (category_name) {
    category = Category.find_by(name: category_name)
    where(category_id: category.id) if category
  }
end
