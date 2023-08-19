class ShoppingCartsController < ApplicationController
    before_action :get_shopping_cart,only: [:update,:destroy]

    def index
        fetch_home_data
        @shopping_carts = ShoppingCart.find_by_user_uuid(session[:user_uuid])
                            .includes([:product => [:main_product_image]])
                            .order(id: :desc)
        
    end

    def create
        amount = params[:amount].to_i
        amount = amount <= 0 ? 1 : amount
        @product = Product.find(params[:product_id])

        @shopping_cart = ShoppingCart.create_or_update!({
            user_uuid: session[:user_uuid],
            product_id: params[:product_id],
            amount: amount
        })

        respond_to do |format|
            format.html { render :create,layout: false, notice: 'Resource was successfully created.' }
            format.json { render json: @shopping_cart, status: :ok }
        end
    end

    def update
       
        if @shopping_cart 
            amount = params[:amount].to_i
            amount = amount <= 0 ? 1 : amount
            @shopping_cart.update(amount: amount)
        end

        redirect_to shopping_carts_path
    end

    def destroy
        
        if @shopping_cart
            @shopping_cart.destroy
        end
        redirect_to shopping_carts_path
    end

    private

    def get_shopping_cart
        @shopping_cart = ShoppingCart.find_by_user_uuid(session[:user_uuid])
                    .where(id:params[:id]).first
    end
end