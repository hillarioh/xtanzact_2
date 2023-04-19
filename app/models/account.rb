class Account < ApplicationRecord
    enum :account_type, { current: 0, savings: 1 }

    belongs_to :user
    has_many :sent_transactions, foreign_key: "sender_id", class_name: 'Transaction'
    has_many :received_transactions, foreign_key: "receiver_id", class_name: 'Transaction'
end
