class SessionsController < ApplicationController

    def new
        fetch_home_data
    end

    def create
       if user = login(params[:email],params[:password])
        # 更新购物车数量 如果用户存在该商品的话就直接覆盖,没有就是新增
        user_shopping_carts = ShoppingCart.where(user_uuid: user.uuid)
        anonymous_shopping_carts = ShoppingCart.where(user_uuid: session[:user_uuid])
        anonymous_shopping_carts.each do |cart|
            # 如果包含该商品就直接覆盖数量
            user_cart =  user_shopping_carts.find { |user_cart| user_cart.product == cart.product }
            if user_cart
                user_cart.destroy
            end
            cart.update(user_uuid: user.uuid)
        end
        update_session_and_cookies_uuid user.uuid
        flash[:notice] = "登录成功"
        redirect_to root_path
        
       else
        flash[:notice] = "登录失败,邮箱或者密码不正确"
        redirect_to new_session_path
       end
    end

    def destroy
        logout
        update_session_and_cookies_uuid nil
        
        flash[:notice] = "退出成功"
        redirect_to root_path
    end

end