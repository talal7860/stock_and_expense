require 'rails_helper'

RSpec.describe ExpenseCategory, type: :model do
  describe "Associations" do
    it { should have_many(:expenses) }
  end

  describe "Validations" do
    it { should validate_presence_of(:name) }
  end

end
