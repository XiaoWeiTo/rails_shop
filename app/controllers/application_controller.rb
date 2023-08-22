class ApplicationController < ActionController::Base

    before_action :set_browser_uuid

    protected

    def fetch_home_data
        @categories = Category.group_data
        @shopping_carts_count = ShoppingCart.find_by_user_uuid(session[:user_uuid]).count
    end

    def set_browser_uuid
        uuid = cookies[:user_uuid]
        
        if !uuid || uuid.empty?
            if logged_in?
                uuid = current_user.uuid
            else
                uuid = SnowFlake::ID.new(0,0).next_id
            end
        end
        update_session_and_cookies_uuid uuid
    end

    def update_session_and_cookies_uuid uuid
        session[:user_uuid] = cookies[:user_uuid] = uuid
    end

    def auth_user
        unless logged_in?
            flash[:notice] = "请先登录"
            redirect_to new_session_path
        end
    end
end
