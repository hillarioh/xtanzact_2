require 'rails_helper'

RSpec.describe "Authentication", type: :request do
    describe "POST /login" do        
        context "with correct credentials" do
            let (:user) { create(:user) }
            let (:login_params) do
                {
                    email_address: user.email_address,
                    password: "123456"
                }
            end
            
            it "should respond with status 200" do
                login_request '/login', login_params
                expect(response).to have_http_status(200)
            end

            it "should return a token" do
                login_request '/login', login_params
                expect(json_body["token"]).not_to be_nil
            end            
        end
        context "with incorrect credentials" do
            let (:login_params) do
                {
                    email_address: "john@example.com",
                    password: "123456"
                }
            end            
            it "should respond with status 401" do
                login_request '/login', login_params
                expect(response).to have_http_status(401)
            end
            it "should return unauthorized" do
                login_request '/login', login_params
                expect(json_body["error"]).to eq("unauthorized")
            end            
        end       
    end
end