class TransactionList < ApplicationRecord
    belongs_to :account
    belongs_to :transactionable, polymorphic: true

    validates :transactionable_type, :transactionable_id, :account_id, presence: true

    scope :list_of_transactions, ->(u_id) { joins(:account).where("account.user_id": u_id) }
end
