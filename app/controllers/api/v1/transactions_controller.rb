class Api::V1::TransactionsController < ApplicationController
    before_action :find_transaction, only: [:update, :destroy]

    def create
        @transaction = Transaction.new(user_params)
        if @transaction.save
            render json: @transaction, status: :created
        else
            render json: { errors: @transaction.errors.full_messages },
             status: :unprocessable_entity
        end
    end

    def destroy
        @transaction.destroy
    end

    private

    def find_transaction
        @transaction = Transaction.find(params[:id])
    end

    def transaction_params
        params.require(:transaction).permit(:amount, :sender_id, :receiver_id)
    end

end