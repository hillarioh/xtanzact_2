require 'rails_helper'

RSpec.describe "Users", type: :request do
     let (:user) { create(:user) }
    let (:token) { log_in(user) }

    let (:user_params) do
        {
            first_name: "John",
            last_name: "Doe",
            tel_no: "1234567890",
            email_address: "johndoe@gmail.com",
            password: "password"
        }
    end

    describe "GET /api/v1/users" do
        before do
            get_request '/api/v1/users', token
        end

        it "should respond with status 200" do
            expect(response).to have_http_status(200)
        end

        it "should respond with list of values" do
            expect(json_body).to be_an(Array)
        end
    end

    describe "POST /api/v1/users" do
        before do
            register_request '/api/v1/users', {user: user_params}
        end
        it "should create a new user" do
            expect(response).to have_http_status(201)
        end
    end

end