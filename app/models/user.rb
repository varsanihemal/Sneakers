class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :cart, dependent: :destroy
  has_many :orders
  has_many :reviews
  belongs_to :province

  validates :city, presence: true
  validates :postal_code, presence: true
  validates :address, presence: true
  validates :province_id, presence: true

  # Automatically create a cart for the user upon creation
  after_create :create_cart

  # Convenience method to get the current cart
  def current_cart
    cart || create_cart
  end

  private

  # Creates a cart for the user
  def create_cart
    Cart.create(user: self)
  end
end
