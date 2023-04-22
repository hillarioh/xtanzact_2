class Api::V1::AccountsController < ApplicationController
    before_action :find_Account, only: [:update, :destroy, :deposit, :withdraw]

    def index
        @accounts = @current_user.accounts
        render json: @accounts, status: :ok
    end

    def update
        if @account.update(account_params)
            render json: @account, status: :ok
        else
            render json: { errors: @account.errors.full_messages },
             status: :unprocessable_entity
        end
    end

    def transact
        if transaction_params[:transaction_type] == "withdraw" 
            check_limit
        else
            handle_transaction
        end       
    end

    def transfer
        sender_account = Account.find(params[:account_id])
        
        if sender_account.balance < params[:amount].to_f
            render json: { message: "You have insufficient funds" }, status: :ok
        else
            receiver = User.find(params[:user_id])
            receiver_account = receiver.accounts.where(account_type: "current").first
            @transfer = Transfer.new(receiver: receiver_account, sender: sender_account, amount: params[:amount])
            if @transfer.save
                details = {}
                details[:amount] = params[:amount]
                details[:recipient] = "#{receiver.first_name} #{receiver.last_name}"
                details[:account_no] = receiver_account.id
                render json: {message: "Funds have been sent", transaction: details }, status: :created
            else
                render json: { errors: @transfer.errors.full_messages },
                status: :unprocessable_entity
            end 
        end

    end


    def destroy
        @account.destroy
    end

    private

    def find_account
        @account = Account.find(params[:id])
    end

    def check_limit
        @account = Account.find(transaction_params[:account_id])
        if @account.balance < transaction_params[:amount].to_f
            render json: { message: "You have insufficient funds" }, status: :ok
        else
            handle_transaction
        end
    end

    def handle_transaction
        @transaction = Transaction.new(transaction_params)
         if @transaction.save
            render json: {message: "Transaction Successful",transaction: @transaction }, status: :created
        else
            render json: { errors: @transaction.errors.full_messages },
            status: :unprocessable_entity
        end 
    end

    def handle_transfer
        @transaction = Transfer.new(transaction_params)
         if @transaction.save
            render json: {message: "Transaction Successful",transaction: @transaction }, status: :created
        else
            render json: { errors: @transaction.errors.full_messages },
            status: :unprocessable_entity
        end 
    end

    def account_params
        params.require(:account).permit(:account_type, :user_id)
    end

    def transaction_params
        params.require(:transaction).permit(:account_id, :transaction_type, :amount)
    end

    def transfer_params
        params.permit(:account_id,:user_id,:amount)
    end
end