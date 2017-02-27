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

    it "should create a transaction after a stock is sold with a credit transaction" do
      stock_out = FactoryGirl::create(:stock_out)
      expect(stock_out.company_transaction.id).to eq(CompanyTransaction.first.id)
    end

    it "should credit the transaction table" do
      stock_out = FactoryGirl::create(:stock_out)
      expect(stock_out.company_transaction.transaction_type).to eq("credit")
    end

    it "should set the transaction amount with stock quantity" do
      stock_out = FactoryGirl::create(:stock_out)
      expect(stock_out.company_transaction.amount_cents).to eq(stock_out.amount_cents * stock_out.quantity)
    end

    it "should decrement the remaining stocks" do
      stock_in = FactoryGirl::create(:stock_in)
      stock_out = FactoryGirl::create(:stock_out, sku: stock_in.sku)
      expect(stock_out.sku.remaining).to eq(0)
    end
  end
  describe "#Update" do
    context "stocks increase" do
      it "should increase the stocks remaining for that sku" do
        stock_in = FactoryGirl::create(:stock_in)
        stock_in.update(quantity: 6)
        expect(stock_in.sku.remaining).to eq(6 * stock_in.sku.quantity)
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
