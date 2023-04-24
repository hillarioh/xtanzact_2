class Transaction < ApplicationRecord
    enum :transaction_type, { deposit: 0, withdraw: 1 }    
    belongs_to :account
    has_many :transaction_lists, as: :transactionable

    validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0.0 }
    validates :transaction_type, presence: true

    after_create :update_account 

    def update_account
        TransactionJob.perform_now(id)
    end
end
