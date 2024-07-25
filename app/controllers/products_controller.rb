class ProductsController < ApplicationController
  # No before_action :authenticate_user! here

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
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: 'Product not found'
  end
end
