class Transfer < ApplicationRecord
    belongs_to :sender, class_name: 'Account'
    belongs_to :receiver, class_name: 'Account'
    has_many :transaction_lists, as: :transactionable

    after_create :reconcile_accounts

    validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0.0 }

    validates :sender_id, presence: true
    validates :receiver_id, presence: true

    private

    def reconcile_accounts
        TransferJob.perform_now(id)
    end
end
