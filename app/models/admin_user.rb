class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable
  has_many :expenses
  has_many :company_wallets
  has_many :stock_ins
  has_many :stock_outs
  has_many :company_transactions
end
