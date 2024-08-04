class HomeController < ApplicationController
  def index
    @products = Product.all

    # Filter by keyword if provided
    if params[:keyword].present?
      keyword = params[:keyword].downcase
      @products = @products.where("LOWER(name) LIKE ? OR LOWER(description) LIKE ?", "%#{keyword}%", "%#{keyword}%")
    end

    # Filter by category if provided
    if params[:category_id].present? && params[:category_id].present?
      @products = @products.where(category_id: params[:category_id])
    end

    # Paginate the results
    @products = @products.page(params[:page]).per(5) # Adjust per(5) to your desired number of items per page
  end
end
