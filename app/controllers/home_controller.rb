class HomeController < ApplicationController
  def index
    @products = Product.all
    @products = filter_by_keyword(@products)
    @products = filter_by_category(@products)
    @products = @products.page(params[:page]).per(5)
  end

  private

  def filter_by_keyword(products)
    return products if params[:keyword].blank?

    keyword = params[:keyword].downcase
    products.where("LOWER(name) LIKE ? OR LOWER(description) LIKE ?", "%#{keyword}%",
                   "%#{keyword}%")
  end

  def filter_by_category(products)
    return products if params[:category_id].blank?

    products.where(category_id: params[:category_id])
  end
end
