# app/controllers/static_pages_controller.rb
class StaticPagesController < ApplicationController
  def show
    @static_page = StaticPage.find_by(title: params[:title].capitalize)
    return unless @static_page.nil?

    render file: "public/404.html", status: :not_found
  end
end
