class ProductImage < ApplicationRecord
  belongs_to :product
  has_one_attached :image # Assuming you are using Active Storage for images
end
