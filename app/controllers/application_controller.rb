class ApplicationController < ActionController::Base


    protected

    def fetch_home_data
        @categories = Category.group_data
    end
end
