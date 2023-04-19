class Transaction < ApplicationRecord
    belongs_to :sender, class_name: 'Account'
    belongs_to :receiver, class_name: 'Account'
end
