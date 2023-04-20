class Api::V1::AccountsController < ApplicationController
    before_action :find_Account, only: [:update, :destroy]


    def create
        @account = Account.new(account_params)
        if @account.save
            render json: @account, status: :created
        else
            render json: { errors: @account.errors.full_messages },
             status: :unprocessable_entity
        end
    end

    def update
        if @account.update(account_params)
            render json: @account, status: :ok
        else
            render json: { errors: @account.errors.full_messages },
             status: :unprocessable_entity
        end
    end

    def destroy
        @Account.destroy
    end

    private

    def find_account
        @account = Account.find(params[:id])
    end

    def account_params
        params.require(:account).permit(:account_type, :user_id)
    end

end