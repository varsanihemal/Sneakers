class ProductImage < ApplicationRecord
  belongs_to :product
  has_one_attached :image # Using Active Storage to attach images

  # Validations
  validates :image, presence: true
end
