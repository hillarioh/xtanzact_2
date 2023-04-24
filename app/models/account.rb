class Account < ApplicationRecord
    enum :account_type, { current: 0, savings: 1 }

    belongs_to :user
    has_many :transactions, :dependent => :destroy
    has_many :transaction_lists

    has_many :sent_transfers, foreign_key: "sender_id", class_name: 'Transfer'
    has_many :received_transfers, foreign_key: "receiver_id", class_name: 'Transfer'

    validates :balance, presence:true, numericality: { greater_than_or_equal_to: 0.0 }
    validates :account_type, presence: true
end
