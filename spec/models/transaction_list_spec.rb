require 'rails_helper'

RSpec.describe TransactionList, type: :model do

  describe "Validations" do
    [:account_id, :transactionable_id, :transactionable_type].each do |field|
      it { should validate_presence_of(field) }
    end
  end

    describe "Associations" do
      it { should belong_to(:account) }
      it { should belong_to(:transactionable) }
    end

end