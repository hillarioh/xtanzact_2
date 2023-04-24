require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe "Validates presence of" do
    [:amount, :transaction_type].each do |field|
      it { should validate_presence_of(field) }
    end

    describe "Numericality" do
      it { should validate_numericality_of(:amount).is_greater_than_or_equal_to(0.0) }
    end
  end

  describe "Associations" do
    it { should have_many(:transaction_lists) }
  end
end