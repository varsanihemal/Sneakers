# app/controllers/categories_controller.rb
class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @casual_shoes = Product.where(category_id: @category.id) # Adjust the filter criteria as needed
  end
end
