class OrdersController < ApplicationController
  before_action :set_cart
  before_action :set_provinces, only: %i[new create]
  before_action :set_order, only: [:show]
  before_action :authenticate_user!

  def index
    @orders = current_user.orders
  end

  def show; end

  def new
    @order = Order.new
    @payment_intent = Stripe::PaymentIntent.create(
      amount:               (@cart.total_amount * 100).to_i, # Amount in cents
      currency:             "cad", # Canadian dollars
      payment_method_types: ["card"]
    )
    @provinces = Province.all
  end

  def create
    @order = build_order

    if @order.save
      create_order_items
      clear_cart
      redirect_to @order, notice: "Order was successfully created."
    else
      render :new
    end
  end

  private

  def build_order
    Order.new(order_params).tap do |order|
      order.user = current_user
      order.province = Province.find(params[:order][:province_id])
    end
  end

  def create_order_items
    @cart.cart_items.each do |cart_item|
      @order.order_items.create(
        product:           cart_item.product,
        quantity:          cart_item.quantity,
        price_at_purchase: cart_item.product.price
      )
    end
  end

  def clear_cart
    @cart.cart_items.destroy_all
  end

  def order_params
    params.require(:order).permit(:address, :city, :postal_code, :province_id, :payment_intent_id)
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
    redirect_to orders_path
  end
end
