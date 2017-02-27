require 'rails_helper'

RSpec.describe StockIn, type: :model do
  describe "Associations" do
    it { should belong_to(:added_by).with_foreign_key(:added_by_id).class_name('AdminUser') }
    it { should belong_to(:sku) }
    it { should belong_to(:client) }
    it { should have_one(:company_transaction) }
  end

  describe "Validations" do
    it { should validate_presence_of(:added_by) }
    it { should validate_presence_of(:client) }
    it { should validate_presence_of(:sku) }
    it { should validate_numericality_of(:quantity).is_greater_than(0) }
  end
  describe "#Creation" do
    it "should successfully create an object" do
      expect{
        FactoryGirl::create(:stock_in)
      }.to change{StockIn.count}.by(1)
    end

    it "should create a transaction after a stock is bought with a debit transaction" do
      stock_in = FactoryGirl::create(:stock_in)
      expect(stock_in.company_transaction.id).to eq(CompanyTransaction.first.id)
    end

    it "should debit the transaction table" do
      stock_in = FactoryGirl::create(:stock_in)
      expect(stock_in.company_transaction.transaction_type).to eq("debit")
    end

    it "should set the transaction amount with stock quantity" do
      stock_in = FactoryGirl::create(:stock_in)
      expect(stock_in.company_transaction.amount_cents).to eq(stock_in.amount_cents * stock_in.quantity)
    end

    it "should increment the remaining stocks" do
      stock_in = FactoryGirl::create(:stock_in)
      expect(stock_in.sku.remaining).to eq(60)
    end
  end
  describe "#Update" do
    context "stocks decrease" do
      it "should decrease the stocks remaining for that sku" do
        stock_in = FactoryGirl::create(:stock_in)
        stock_in.update(quantity: 6)
        expect(stock_in.sku.remaining).to eq(36)
      end

      it "should decrease the company transaction" do
        stock_in = FactoryGirl::create(:stock_in)
        stock_in.update(quantity: 6)
        expect(stock_in.company_transaction.amount_cents).to eq(stock_in.amount_cents * stock_in.quantity)
      end
    end
    context "stocks increase" do
      it "should increase the stocks remaining for that sku" do
        stock_in = FactoryGirl::create(:stock_in)
        stock_in.update(quantity: 16)
        expect(stock_in.sku.remaining).to eq(16 * stock_in.sku.quantity)
      end

      it "should decrease the company transaction" do
        stock_in = FactoryGirl::create(:stock_in)
        stock_in.update(quantity: 6)
        expect(stock_in.company_transaction.amount_cents).to eq(stock_in.amount_cents * stock_in.quantity)
      end
    end
  end
end
