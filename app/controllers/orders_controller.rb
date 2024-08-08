class OrdersController < ApplicationController
  before_action :set_cart
  before_action :set_provinces, only: [:new, :create]
  before_action :set_order, only: [:show]
  before_action :authenticate_user!

  def index
    @orders = current_user.orders
  end

  def new
    @order = Order.new
    @provinces = Province.all

    if @cart.total_amount > 0
      @payment_intent = Stripe::PaymentIntent.create(
        amount: (@cart.total_amount * 100).to_i, # Amount in cents
        currency: 'cad', # Canadian dollars
        payment_method_types: ['card']
      )
    else
      @payment_intent = nil
    end
  end

  # app/controllers/orders_controller.rb
def create
  @order = Order.new(order_params)
  @order.user = current_user
  @order.province = Province.find(params[:order][:province_id])

  # Calculate subtotal and total amount
  @cart_items = @cart.cart_items.includes(:product)
  subtotal = @cart_items.sum { |item| item.product.price * item.quantity }
  @order.total_amount = subtotal + @order.gst + @order.pst + @order.hst

  Rails.logger.debug "Subtotal: #{subtotal}, Total Amount: #{@order.total_amount}"

  if @order.save
    @cart.cart_items.each do |cart_item|
      @order.order_items.create(
        product: cart_item.product,
        quantity: cart_item.quantity,
        price_at_purchase: cart_item.product.price
      )
    end
    # Clear the cart after creating the order
    @cart.cart_items.destroy_all

    # Handle payment confirmation if needed
    if @order.payment_intent_id
      # Additional Stripe confirmation logic here
    end

    redirect_to @order, notice: 'Order was successfully created.'
  else
    render :new
  end
end


  private

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
