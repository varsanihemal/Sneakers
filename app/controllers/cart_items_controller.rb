class CartItemsController < ApplicationController
  before_action :set_cart

  def create
    product = Product.find(params[:product_id])
    quantity = params[:quantity].to_i # Get the quantity from params and convert it to an integer

    @cart_item = @cart.cart_items.find_by(product:)

    if @cart_item
      # Update the quantity of an existing cart item
      @cart_item.update(quantity: @cart_item.quantity + quantity)
    else
      # Create a new cart item with the specified quantity
      @cart_item = @cart.cart_items.create(product:, quantity:)
    end

    redirect_to cart_path(@cart)
  end

  def update
    @cart_item = @cart.cart_items.find(params[:id])
    new_quantity = params[:quantity].to_i

    if new_quantity.positive?
      @cart_item.update(quantity: new_quantity)
    else
      @cart_item.destroy
    end

    redirect_to cart_path(@cart)
  end

  def destroy
    @cart_item = @cart.cart_items.find(params[:id])
    @cart_item.destroy
    redirect_to cart_path(@cart)
  end

  private

  def set_cart
    @cart = current_user.cart
  end
end
