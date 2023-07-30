class HomeController < ApplicationController
  def index
    fetch_home_data
    @products = Product.onshelf
                .page(params[:page] || 1)
                .per_page(params[:per_page] || 10)
                .order(id: :desc)
                .includes(:main_product_image)
  end
end
