class CartController < ApplicationController
  before_action :authenticate_user! # Ensure user is signed in to view cart

  def show
    @cart = current_user.cart
  end
end
