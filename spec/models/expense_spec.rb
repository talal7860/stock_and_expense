require 'rails_helper'

RSpec.describe Expense, type: :model do
  describe "Associations" do
    it { should belong_to(:added_by).with_foreign_key(:added_by_id).class_name("AdminUser") }
    it { should have_one(:company_transaction) }
    it { should belong_to(:expense_category) }
    it { should belong_to(:admin_user) }
  end

  describe "Validations" do
    it { should validate_presence_of(:added_by) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:expense_category_name) }
  end

  describe "#Create" do
    it "should create an expense successfully" do
      expect{
        FactoryGirl::create(:expense)
      }.to change{Expense.count}.by(1)
    end
    context "expense category" do
      it "should create an expense category successfully" do
        expect{
          FactoryGirl::create(:expense)
        }.to change{ExpenseCategory.count}.by(1)
      end
      it "should not create a new expense category for the same expense name" do
        expect{
          FactoryGirl::create(:expense)
          FactoryGirl::create(:expense)
        }.to change{ExpenseCategory.count}.by(1)
      end
    end
    context "#CompanyTransaction" do
      it "should create an company transaction for this expense" do
        expect{
          FactoryGirl::create(:expense)
        }.to change{CompanyTransaction.count}.by(1)
      end
      it "should create an company transaction with type debit" do
        expense = FactoryGirl::create(:expense)
        expect(expense.company_transaction.transaction_type).to eq("debit")
      end
    end
  end

  describe "#Update" do
    it "should update the company transaction" do
      expense = FactoryGirl::create(:expense)
      expense.update(amount_cents: 300)
      expect(expense.company_transaction.amount_cents).to eq(300)
    end
  end
end
