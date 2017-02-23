class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable
  has_many :added_expenses, foreign_key: :added_by_id
  has_many :company_wallets, foreign_key: :added_by_id
  has_many :stock_ins, foreign_key: :added_by_id
  has_many :stock_outs, foreign_key: :added_by_id
  has_many :company_transactions, foreign_key: :added_by_id
end
