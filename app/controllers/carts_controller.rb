# app/controllers/carts_controller.rb
class CartsController < ApplicationController
  before_action :authenticate_user! # Ensure user is signed in to view cart

  def show
    @cart = current_user.carts.first
    # Or, if you have a way to mark an active cart:
    # @cart = current_user.carts.find_by(active: true)
  end
end
