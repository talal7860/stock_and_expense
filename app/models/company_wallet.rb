class CompanyWallet < ApplicationRecord
  belongs_to :added_by, foreign_key: :added_by_id, class_name: "AdminUser"
  has_one :company_transaction, as: :transactable

  validates_presence_of :detail, :added_by
  monetize :amount_cents, :allow_nil => false
end
