require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe "Associations" do
    it { should have_many(:stock_outs) }
  end

  describe "Validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:phone_number) }
    it { should validate_presence_of(:address) }
  end

  describe "#Creation" do
    it "should successfully create an object" do
      expect{
        FactoryGirl::create(:customer)
      }.to change{Customer.count}.by(1)
    end
  end
end
