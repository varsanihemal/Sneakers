class OrdersController < ApplicationController
  before_action :set_cart
  before_action :set_provinces, only: [:new, :create]
  before_action :set_order, only: [:show]
  before_action :authenticate_user!

  def index
    @orders = current_user.orders.order(created_at: :desc)
  end

  def show
    if @order.order_items.empty?
      flash[:alert] = "No items found in the order."
      redirect_to orders_path
    end
  end

  def new
    @order = Order.new
    # Ensure @provinces is set in `set_provinces` before rendering `new` view
  end

  def create
    Rails.logger.debug "Order Params: #{order_params.inspect}"

    @order = Order.new(order_params)
    @order.user_id = current_user.id

    # Ensure that province_id is present and valid
    province_id = params[:order][:province_id]
    if province_id.present?
      begin
        @order.province = Province.find(province_id)
      rescue ActiveRecord::RecordNotFound => e
        Rails.logger.debug "Province not found: #{e.message}"
        flash[:error] = "Province not found."
        render :new and return
      end
    else
      flash[:error] = "Province ID is missing."
      render :new and return
    end

    if @order.save
      current_user.cart.cart_items.each do |cart_item|
        @order.order_items.create!(
          product: cart_item.product,
          price_at_purchase: cart_item.product.price,
          quantity: cart_item.quantity
        )
      end

      current_user.cart.cart_items.destroy_all

      # Redirect to the order's show page (invoice)
      redirect_to @order, notice: 'Order was successfully created. Your invoice is available.'
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
    redirect_to orders_path
  end
end
