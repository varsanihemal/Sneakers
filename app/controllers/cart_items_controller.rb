class CartItemsController < ApplicationController
  before_action :set_cart

  def create
    product = Product.find(params[:product_id])
    @cart_item = @cart.cart_items.find_by(product: product)

    if @cart_item
      @cart_item.increment!(:quantity)
    else
      @cart_item = @cart.cart_items.create(product: product, quantity: 1)
    end

    redirect_to cart_path(@cart)
  end

  def update
    @cart_item = @cart.cart_items.find(params[:id])
    new_quantity = params[:quantity].to_i

    if new_quantity > 0
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
