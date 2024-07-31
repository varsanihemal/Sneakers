class HomeController < ApplicationController
  def index
    @products = Product.page(params[:page]).per(5) # Adjust per(10) to your desired number of items per page
  end
end
