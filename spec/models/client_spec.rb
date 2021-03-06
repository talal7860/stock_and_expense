require 'rails_helper'

RSpec.describe Client, type: :model do
  describe "Associations" do
    it { should have_many(:stock_ins) }
  end

  describe "Validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:phone_number) }
    it { should validate_presence_of(:address) }
  end

  describe "#Creation" do
    it "should successfully create an object" do
      expect{
        FactoryGirl::create(:client)
      }.to change{Client.count}.by(1)
    end
  end
end
