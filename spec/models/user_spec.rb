require 'rails_helper'

RSpec.describe User, type: :model do

  describe "Validates presence of" do
      [:first_name, :last_name, :tel_no, :email_address].each do |field|
        it { should validate_presence_of(field) }
      end
  end

    describe "Associations" do
      it { should have_many(:accounts).dependent(:destroy) }
    end
end