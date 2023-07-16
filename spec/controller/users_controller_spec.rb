require 'rails_helper'

RSpec.describe UsersController,type: :controller do

    context "signup" do
        it "should be failure" do 
            post :create,params: { user: { email: "test" } }
            expect(response).to render_template("new")
        end

        it "should be successful" do
            post :create,params: {
                user: {
                    email: "777@qq.com",
                    password: "111111",
                    password_confirmation: "111111"
                }
            }

            expect(response).to redirect_to(new_session_path)
        end
    end
end