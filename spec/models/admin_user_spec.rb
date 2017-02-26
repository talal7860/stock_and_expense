require 'rails_helper'

RSpec.describe AdminUser, type: :model do
  describe "Validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:phone_number) }
    it { should validate_uniqueness_of(:username) }
  end

  describe "Associations" do
    it { should have_many(:added_expenses).class_name('Expense') }
    it { should have_many(:expenses).class_name('Expense') }
    it { should have_many(:added_company_wallets).class_name('CompanyWallet') }
    it { should have_many(:added_stock_ins).class_name('StockIn') }
    it { should have_many(:added_stock_outs).class_name('StockOut') }
  end

  describe "Creation" do
    it "should create an admin user successfully" do
      expect{
        FactoryGirl::create(:admin_user)
      }.to change{ AdminUser.count }.by(1)
    end
  end
end

