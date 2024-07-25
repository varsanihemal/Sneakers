class Product < ApplicationRecord
  # Associations
  has_many :cart_items
  has_many :order_items
  has_many :reviews
  belongs_to :category
  has_many :product_images, dependent: :destroy

  def self.casual_shoes
    where(category_id: Category.find_by(name: 'Casual Shoes').id)
  end

  # ActiveStorage for image attachments (if needed)
  has_one_attached :image
end
