class Product < ApplicationRecord
  has_many :cart_items
  has_many :order_items
  has_many :reviews
  belongs_to :category
  has_many :product_images

  mount_uploader :image_url, ImageUploader
end
