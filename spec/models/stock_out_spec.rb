require 'rails_helper'

RSpec.describe StockOut, type: :model do
  describe "Associations" do
    it { should belong_to(:added_by).with_foreign_key(:added_by_id).class_name('AdminUser') }
    it { should belong_to(:sku) }
    it { should belong_to(:customer) }
    it { should have_one(:company_transaction) }
  end

  describe "Validations" do
    it { should validate_presence_of(:added_by) }
    it { should validate_presence_of(:customer) }
    it { should validate_presence_of(:sku) }
    it { should validate_numericality_of(:quantity).is_greater_than(0) }
  end
  describe "#Creation" do
    it "should successfully create an object" do
      expect{
        FactoryGirl::create(:stock_out)
      }.to change{StockOut.count}.by(1)
    end

    it "should create a transaction after a stock is sold with a debit transaction" do
      stock_out = FactoryGirl::create(:stock_out)
      expect(stock_out.company_transaction.id).to eq(CompanyTransaction.first.id)
      expect(stock_out.company_transaction.transaction_type).to eq("debit")
      expect(stock_out.company_transaction.amount_cents).to eq(stock_out.amount_cents * stock_out.quantity)
    end
  end
end
