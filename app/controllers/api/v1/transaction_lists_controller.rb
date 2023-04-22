class Api::V1::TransactionListsController < ApplicationController

    def index
        @t_list = TransactionList.list_of_transactions @current_user.id

        list = @t_list.map do |t|
            if t.transactionable_type == "Transaction"
                handle_transaction t
            else
                handle_transfer t
            end
                
        end
        render json: { transactions: list}, status: :ok
    end

    private

    def handle_transaction t
        details = {}
        klass = "#{t.transactionable_type}".constantize
        tn = klass.find(t.transactionable_id)
        details[:transaction_id] = t.id
        details[:amount] = tn.amount
        details[:type] = tn.transaction_type
        details[:transaction_date] = tn.created_at.to_fs(:db)
        details
    end

    def handle_transfer t
        details = {}
        klass = "#{t.transactionable_type}".constantize
        tn = klass.find(t.transactionable_id)
        receiver = Account.find(tn.receiver_id)
        user = User.find(receiver.user_id)
        details[:transaction_id] = t.id
        details[:amount] = tn.amount
        details[:recipient] = "#{user.first_name} #{user.last_name}"
        details[:type] = t.transactionable_type
        details[:transaction_date] = tn.created_at.to_fs(:db)
        details
    end
end
