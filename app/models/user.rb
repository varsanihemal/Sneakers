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

  after_create :create_cart

  def current_cart
    cart || create_cart
  end

  private

  def create_cart
    Cart.create(user: self)
  end
end
