class UsersController < ApplicationController
    def new
        fetch_home_data
        @user = User.new
    end

    def create
        @user = User.new(params.require(:user).permit(:email,:password,:password_confirmation))
        @user.uuid = session[:user_uuid]
        if @user.save
            flash[:notice] = "注册成功,请登录"
            redirect_to new_session_path
        else
            render action: :new
        end
    end
end