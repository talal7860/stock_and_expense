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
end
