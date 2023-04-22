class Account < ApplicationRecord
    enum :account_type, { current: 0, savings: 1 }

    belongs_to :user
    has_many :transactions, :dependent => :destroy
    has_many :transaction_lists

    has_many :sent_transfers, foreign_key: "sender_id", class_name: 'Transfer'
    has_many :received_transfers, foreign_key: "receiver_id", class_name: 'Transfer'

    scope :current_account, -> (u_id) { where(account_type: 'current', user_id: u_id).limit(1) }
end
