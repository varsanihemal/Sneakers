class CartsController < ApplicationController
  before_action :set_cart

  def show
    @cart_items = @cart.cart_items.includes(:product)
  end

  def update_cart_item
    @cart_item = @cart.cart_items.find(params[:id])
    new_quantity = params[:quantity].to_i

    if new_quantity.positive?
      @cart_item.update(quantity: new_quantity)
    else
      @cart_item.destroy
    end

    redirect_to cart_path(@cart)
  end

  private

  def set_cart
    @cart = current_user.cart
  end
end
