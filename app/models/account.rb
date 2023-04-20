class Account < ApplicationRecord
    enum :account_type, { current: 0, savings: 1 }

    belongs_to :user
    has_many :transactions

    has_many :sent_transfers, foreign_key: "sender_id", class_name: 'Transfer'
    has_many :received_transfers, foreign_key: "receiver_id", class_name: 'Transfer'
end
