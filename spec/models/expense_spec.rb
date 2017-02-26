require 'rails_helper'

RSpec.describe Expense, type: :model do
  describe "Associations" do
    it { should belong_to(:added_by).with_foreign_key(:added_by_id).class_name("AdminUser") }
    it { should have_many(:company_transactions) }
    it { should belong_to(:expense_category) }
    it { should belong_to(:admin_user) }
  end

  describe "Validations" do
    it { should validate_presence_of(:added_by) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:expense_category) }
  end
end
