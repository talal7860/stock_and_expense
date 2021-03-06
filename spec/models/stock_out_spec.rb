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
    it { should validate_numericality_of(:quantity).is_greater_than_or_equal_to(0) }
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
      expect(stock_out.company_transaction.amount_cents).to eq(stock_out.amount_paid_cents)
      expect(stock_out.customer.amount_paid_cents).to eq(stock_out.amount_paid_cents)
    end

    it "should make sure that the customer amount paid is not equal to stock amount paid" do
      stock_out = FactoryGirl::create(:stock_out)
      FactoryGirl::create(:stock_out, customer: stock_out.customer)
      expect(stock_out.customer.amount_paid_cents).not_to eq(stock_out.amount_paid_cents)
    end

    it "should set the transaction to the amount paid and add the price to amount due" do
      stock_out = FactoryGirl::create(:stock_out_less)
      second_stock = FactoryGirl::create(:stock_out, customer: stock_out.customer)
      expect(stock_out.company_transaction.amount_cents).to eq(stock_out.amount_paid_cents)
      expect(stock_out.customer.amount_paid_cents).to eq(stock_out.amount_paid_cents + second_stock.amount_paid_cents)
    end

    it "should set the amount due in customer" do
      stock_out = FactoryGirl::create(:stock_out_less)
      expect(stock_out.customer.amount_due_cents).to eq(stock_out.amount_cents - stock_out.amount_paid_cents)
    end

    it "should decrement the remaining stocks" do
      stock_in = FactoryGirl::create(:stock_in, quantity: 10)
      stock_out = FactoryGirl::create(:stock_out, sku: stock_in.sku, quantity: 10)
      expect(stock_out.sku.remaining).to eq(0)
    end
    context "#pet" do
      it 'should decrease the stocks pet wise' do
        stock_out = FactoryGirl::create(:stock_out, stock_unit: 'pet')
        expect(stock_out.sku.remaining).to eq(-120)
      end
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
        expect(stock_out.company_transaction.amount_cents).to eq(stock_out.amount_paid_cents)
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
        expect(stock_out.company_transaction.amount_cents).to eq(stock_out.amount_paid_cents)
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
