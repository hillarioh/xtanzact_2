class Transaction < ApplicationRecord
    enum :transaction_type, { deposit: 0, withdraw: 1 }    
    belongs_to :account
    has_many :transaction_lists, as: :transactionable

    after_create :update_account 

    def update_account
        TransactionJob.perform_now(id)
    end
end
