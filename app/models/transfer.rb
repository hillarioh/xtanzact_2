class Transfer < ApplicationRecord
    belongs_to :sender, class_name: 'Account'
    belongs_to :receiver, class_name: 'Account'
    has_many :transaction_lists, as: :transactionable

    after_create :reconcile_accounts

    private

    def reconcile_accounts
        TransferJob.perform_now(id)
    end
end
