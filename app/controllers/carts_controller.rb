class CartsController < ApplicationController
  before_action :authenticate_user!, only: [:checkout, :update]

  def show
    # Display user's cart
  end

  def checkout
    # Handle checkout process, requires authentication
  end

  def update
    # Update cart items, requires authentication
  end
end
