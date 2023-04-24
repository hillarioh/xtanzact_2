require 'rails_helper'

RSpec.describe Transfer, type: :model do

  subject { build(:transfer) }

  describe "Validates presence of" do
    [:amount, :sender_id, :receiver_id].each do |field|
      it { should validate_presence_of(field) }
    end

    describe "Numericality" do
      it { should validate_numericality_of(:amount).is_greater_than_or_equal_to(0.0) }
    end

    describe "Associations" do
      it { should belong_to(:sender).class_name('Account') }
      it { should belong_to(:receiver).class_name('Account') }
      it { should have_many(:transaction_lists) }
    end
  end
end