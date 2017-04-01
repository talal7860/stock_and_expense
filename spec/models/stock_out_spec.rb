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
      expect(stock_out.company_transaction.amount_cents).to eq(stock_out.amount_cents)
    end

    it "should decrement the remaining stocks" do
      stock_in = FactoryGirl::create(:stock_in, quantity: 10)
      stock_out = FactoryGirl::create(:stock_out, sku: stock_in.sku, quantity: 10)
      expect(stock_out.sku.remaining).to eq(0)
    end
  end
  describe "#Update" do
    context "stocks decrease" do
      it "should increase the stocks remaining for that sku" do
        stock_out = FactoryGirl::create(:stock_out)
        stock_out.update(quantity: 6)
        expect(stock_out.sku.remaining).to eq(-6)
      end

      it "should decrease the company transaction" do
        stock_out = FactoryGirl::create(:stock_out)
        stock_out.update(quantity: 6)
        expect(stock_out.company_transaction.amount_cents).to eq(stock_out.amount_cents)
      end
    end
    context "stocks increase" do
      it "should increase the stocks remaining for that sku" do
        stock_out = FactoryGirl::create(:stock_out)
        stock_out.update(quantity: 16)
        expect(stock_out.sku.remaining).to eq(-16)
      end

      it "should decrease the company transaction" do
        stock_out = FactoryGirl::create(:stock_out)
        stock_out.update(quantity: 6)
        expect(stock_out.company_transaction.amount_cents).to eq(stock_out.amount_cents)
      end
    end
  end
  describe "#Destroy" do
    it "should add the stocks removed from the stocks" do
      stock_out = FactoryGirl::create(:stock_out)
      sku = stock_out.sku
      stock_out.destroy
      sku.reload
      expect(sku.remaining).to eq(0)
    end
    it "should remove the transaction from stock in" do
      stock_out = FactoryGirl::create(:stock_out)
      stock_out.destroy
      expect(CompanyTransaction.count).to eq(0)
    end
  end
end
