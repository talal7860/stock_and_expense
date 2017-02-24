class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable
  has_many :added_expenses, foreign_key: :added_by_id, class_name: "Expense"
  has_many :expenses
  has_many :added_company_wallets, foreign_key: :added_by_id, class_name: "CompanyWallet"
  has_many :added_stock_ins, foreign_key: :added_by_id, class_name: "StockIn"
  has_many :added_stock_outs, foreign_key: :added_by_id, class_name: "StockOut"
  has_many :added_transactions, foreign_key: :added_by_id, class_name: "CompanyTransaction"
  monetize :salary_cents, allow_nil: true,
    :numericality => {
      :greater_than_or_equal_to => 0
    }

end
