class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:show] # Ensure user is logged in before accessing `show`

  def index
    @categories = Category.all
    @products = if params[:category].present?
                  Product.where(category_id: params[:category])
                else
                  Product.all
                end
    @products = @products.page(params[:page])
  end

  def show
    @product = Product.find(params[:id])
    @cart = current_user.cart if user_signed_in? # Ensure current_user is not nil
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: 'Product not found'
  end
end
