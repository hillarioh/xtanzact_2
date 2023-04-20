class Transaction < ApplicationRecord
    enum :transaction_type, { deposit: 0, withdraw: 1 }
    
    belongs_to :account

end
