require 'rails_helper'

RSpec.describe AdminUser, type: :model do
  it { should have_many(:added_expenses).class_name('Expense') }
  it { should have_many(:expenses).class_name('Expense') }
  it { should have_many(:added_company_wallets).class_name('CompanyWallet') }
  it { should have_many(:added_stock_ins).class_name('StockIn') }
  it { should have_many(:added_stock_outs).class_name('StockOut') }
end

