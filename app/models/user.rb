class User < ApplicationRecord
  has_many :carts
  has_many :orders
  has_many :reviews
end
