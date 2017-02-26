require 'rails_helper'

RSpec.describe Sku, type: :model do
  describe "Associations" do
    it { should have_many(:stock_ins) }
    it { should have_many(:stock_outs) }
  end

  describe "Validations" do
    it { should validate_presence_of(:name) }
  end
end
