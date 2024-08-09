class StaticPage < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    ["content", "created_at", "id", "title", "updated_at"]
  end
end
