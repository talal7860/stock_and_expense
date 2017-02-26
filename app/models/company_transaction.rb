class CompanyTransaction < ApplicationRecord
  belongs_to :added_by, foreign_key: :added_by_id, class_name: "AdminUser"
  validates_presence_of :detail, :transaction_type, :added_by
  enum transaction_type: [
    :debit,
    :credit
  ]
  monetize :amount_cents, :allow_nil => false
end
