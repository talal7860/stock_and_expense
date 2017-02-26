require 'rails_helper'

RSpec.describe CompanyTransaction, type: :model do
  describe "Associations" do
    it { should belong_to(:added_by).with_foreign_key(:added_by_id).class_name("AdminUser") }
  end

  describe "Validations" do
    it { should validate_presence_of(:detail) }
    it { should validate_presence_of(:transaction_type) }
    it { should validate_presence_of(:added_by) }
    it do
      should define_enum_for(:transaction_type).
        with([:debit, :credit])
    end
  end
end
