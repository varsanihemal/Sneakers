class CartItemsController < ApplicationController
  before_action :authenticate_user! # Ensure user is signed in

  def create
    @product = Product.find(params[:product_id])
    @cart = current_user.carts.first_or_create
    @cart_item = @cart.cart_items.find_or_initialize_by(product: @product)

    # Initialize quantity if it is nil
    @cart_item.quantity ||= 0
    @cart_item.quantity += params[:quantity].to_i

    if @cart_item.save
      redirect_to cart_path, notice: 'Product added to cart successfully.'
    else
      redirect_to product_path(@product), alert: 'Unable to add product to cart.'
    end
  end
end
