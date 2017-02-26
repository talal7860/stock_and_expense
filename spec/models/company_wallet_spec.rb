require 'rails_helper'

RSpec.describe CompanyWallet, type: :model do
  describe "Associations" do
    it { should belong_to(:added_by).with_foreign_key(:added_by_id).class_name("AdminUser") }
    it { should have_one(:company_transaction) }
  end

  describe "Validations" do
    it { should validate_presence_of(:detail) }
    it { should validate_presence_of(:added_by) }
  end
end
