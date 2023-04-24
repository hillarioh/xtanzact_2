require 'rails_helper'

RSpec.describe "Accounts", type: :request do

    let (:user_params) do
        {
            first_name: "John",
            last_name: "Doe",
            tel_no: "1234567890",
            email_address: "johndoe@gmail.com",
            password: "password"
        }
    end

    let (:login_params) do
        {
            email_address: "johndoe@gmail.com",
            password: "password"
        }
    end

    # describe "GET /api/v1/accounts" do
    #     before do
    #         register_request "/api/v1/users", {user: user_params}
    #         login_request '/login', login_params
    #         get_request '/api/v1/accounts', json_body["token"]
    #     end

    #     it "should respond with status 200" do
    #         expect(response).to have_http_status(200)
    #     end

    #     it "should return two accounts(savings and current)" do
    #         expect(json_body.length).to eq(2)
    #     end
    # end

    # describe "Deposits" do
    #     before do
    #         register_request "/api/v1/users", {user: user_params}
    #         login_request '/login', login_params
    #     end

    #     let(:transaction_params) do
    #         {
    #             amount: 10000.0,
    #             account_id: Account.first.id,
    #             transaction_type: "deposit"
    #         }
    #     end

    #     it "should return status code 201" do
    #         post_request '/api/v1/accounts/transact',json_body["token"], {transaction: transaction_params}
    #         expect(response).to have_http_status(201)          
    #     end

    #     it "should return success message" do
    #         post_request '/api/v1/accounts/transact',json_body["token"], {transaction: transaction_params}
    #         expect(json_body["message"]).to eq("Transaction Successful")         
    #     end

    #     it "should update account balance" do
    #         value = Account.first.balance.to_f
    #         post_request '/api/v1/accounts/transact',json_body["token"], {transaction: transaction_params}
    #         expect(Account.first.balance).to eq(value + 10000.0)          
    #     end      
    # end

    describe "Withdraw" do
        before do
            register_request "/api/v1/users", {user: user_params}
            login_request '/login', login_params
        end

        context "with sufficient funds" do
            let(:deposit_params) do
                {
                    amount: 10000.0,
                    account_id: Account.first.id,
                    transaction_type: "deposit"
                }
            end

            let(:withdraw_params) do
                {
                    amount: 1000.0,
                    account_id: Account.first.id,
                    transaction_type: "withdraw"
                }
            end

            it "should return status code 201" do
                token = json_body["token"]
                post_request '/api/v1/accounts/transact',token, {transaction: deposit_params}
                post_request '/api/v1/accounts/transact',token, {transaction: withdraw_params}
                expect(response).to have_http_status(201)         
            end

            it "should return success message" do
                token = json_body["token"]
                post_request '/api/v1/accounts/transact',token, {transaction: deposit_params}
                post_request '/api/v1/accounts/transact',token, {transaction: withdraw_params}
                expect(json_body["message"]).to eq("Transaction Successful")         
            end

            it "should update account balance" do
                token = json_body["token"]
                post_request '/api/v1/accounts/transact',token, {transaction: deposit_params}
                value = Account.first.balance.to_f
                post_request '/api/v1/accounts/transact',token, {transaction: withdraw_params}
                expect(Account.first.balance).to eq(value - 1000.0)          
            end
        end    
    end

end