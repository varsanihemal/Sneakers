class OrdersController < ApplicationController
  before_action :set_cart
  before_action :set_provinces, only: [:new, :create]
  before_action :set_order, only: [:show]

  def show
    # @order is now set by the set_order before_action
    # Ensure order_items are not empty
    if @order.order_items.empty?
      flash[:alert] = "No items found in the order."
      redirect_to root_path
    end
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.user_id = current_user.id
    @order.province = Province.find(params[:order][:province_id])

    if @order.save
      # Create order items from cart items
      current_user.cart.cart_items.each do |cart_item|
        @order.order_items.create!(
          product: cart_item.product,
          price_at_purchase: cart_item.product.price,
          quantity: cart_item.quantity
        )
      end

      # Clear the cart
      current_user.cart.cart_items.destroy_all

      redirect_to @order, notice: 'Order was successfully created.'
    else
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(:address, :city, :postal_code, :province_id)
  end

  def set_provinces
    @provinces = Province.all
  end

  def set_cart
    @cart = current_user.cart
  end

  def set_order
    @order = Order.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Order not found."
    redirect_to root_path
  end
end
