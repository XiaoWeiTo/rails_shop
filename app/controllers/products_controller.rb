class ProductsController < ApplicationController
    def show
        fetch_home_data
        @product = Product.find(params[:id])
        @category = @product.category
    end
end