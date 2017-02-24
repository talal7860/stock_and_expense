require 'rails_helper'

RSpec.describe StockIn, type: :model do
  describe "Associations" do
    it { should belong_to(:added_by).foreign_key(:added_by_id).class_name('AdminUser') }
    it { should belong_to(:sku) }
    it { should belong_to(:client) }
  end

  describe "Validations" do
    it { should validate_presence_of(:added_by) }
    it { should validate_presence_of(:client) }
    it { should validate_presence_of(:sku) }
    it { should validate_numericality_of(:quantity).greater_than(1) }
  end
end
