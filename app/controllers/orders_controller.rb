# app/controllers/orders_controller.rb
class OrdersController < ApplicationController
  before_action :set_cart
  before_action :set_provinces, only: [:new, :create]
  before_action :set_order, only: [:show]
  before_action :authenticate_user! # Ensure user is logged in

  def index
    @orders = current_user.orders.order(created_at: :desc)  # Fetch all orders for the logged-in user
  end

  def show
    if @order.order_items.empty?
      flash[:alert] = "No items found in the order."
      redirect_to orders_path
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
      current_user.cart.cart_items.each do |cart_item|
        @order.order_items.create!(
          product: cart_item.product,
          price_at_purchase: cart_item.product.price,
          quantity: cart_item.quantity
        )
      end

      current_user.cart.cart_items.destroy_all

      # Redirect to PayPal for payment
      redirect_to create_paypal_payment_orders_path(order_id: @order.id, order_total: @order.total_amount)
    else
      render :new
    end
  end

  def create_paypal_payment
    @order = Order.find(params[:order_id])
    amount = params[:order_total]

    payment = PayPal::SDK::REST::Payment.new(
      intent:  "sale",
      payer:  { payment_method: "paypal" },
      redirect_urls: {
        return_url: execute_paypal_payment_orders_url(order_id: @order.id),
        cancel_url: new_order_url
      },
      transactions: [{
        item_list: {
          items: [{
            name: "Order ##{@order.id}",
            sku: "item",
            price: amount,
            currency: "USD",
            quantity: 1
          }]
        },
        amount: {
          total: amount,
          currency: "USD"
        },
        description: "Order ##{@order.id} description."
      }]
    )

    if payment.create
      redirect_to payment.links.find{|v| v.method == "REDIRECT"}.href
    else
      flash[:error] = payment.error["message"]
      render :new
    end
  end

  def execute_paypal_payment
    payment = PayPal::SDK::REST::Payment.find(params[:paymentId])

    if payment.execute(payer_id: params[:PayerID])
      # Mark the order as paid in your system
      @order = Order.find(params[:order_id])
      @order.update(status: 'paid') # Ensure you have a `status` field for this

      redirect_to @order, notice: 'Payment was successful.'
    else
      flash[:error] = 'Payment could not be completed.'
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
    redirect_to orders_path
  end
end
