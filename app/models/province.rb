class Province < ApplicationRecord
  has_many :orders, dependent: :destroy

  validates :name, presence: true
  validates :gst_rate, :pst_rate, :hst_rate, numericality: { greater_than_or_equal_to: 0 }
end
