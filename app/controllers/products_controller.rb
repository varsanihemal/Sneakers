class ProductsController < ApplicationController
  def show
    @product = Product.find_by(id: params[:id])
    if @product.nil?
      flash[:alert] = "Product not found."
      redirect_to products_path
    end
  end
end
