class OrdersController < ApplicationController
  before_action :set_cart, only: [:create]
  before_action :set_provinces, only: %i[new create]
  before_action :set_order, only: [:show]

  def new
    @order = Order.new
  end

  def create
    @order = build_order

    if @order.save
      process_order
      redirect_to order_path(@order), notice: "Order was successfully created."
    else
      render :new
    end
  end

  def show
    calculate_order_totals(@order)
  end

  private

  def build_order
    order = Order.new(order_params)
    order.user = current_user
    order.province = Province.find(params[:order][:province_id])
    calculate_order_totals(order)
    order
  end

  def calculate_order_totals(order)
    subtotal = calculate_subtotal
    order.total_amount = subtotal + calculate_taxes
    Rails.logger.debug "Subtotal: #{subtotal}, Total Amount: #{order.total_amount}"
  end

  def calculate_subtotal
    @cart.cart_items.includes(:product).sum { |item| item.product.price * item.quantity }
  end

  def calculate_taxes
    order.gst + order.pst + order.hst
  end

  def process_order
    create_order_items
    @cart.cart_items.destroy_all
    handle_payment
  end

  def create_order_items
    @order.order_items.create(@cart.cart_items.map do |cart_item|
      {
        product:           cart_item.product,
        quantity:          cart_item.quantity,
        price_at_purchase: cart_item.product.price
      }
    end)
  end

  def handle_payment
    return if @order.payment_intent_id.present?

    payment_intent = Stripe::PaymentIntent.create(
      amount:               (@order.total_amount * 100).to_i,
      currency:             "usd",
      payment_method_types: ["card"],
      metadata:             { order_id: @order.id }
    )

    @order.update(payment_intent_id: payment_intent.id)
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
