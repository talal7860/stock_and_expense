class Expense < ApplicationRecord
  belongs_to :expense_category
  belongs_to :added_by, foreign_key: :added_by_id, class_name: "AdminUser"
  belongs_to :admin_user
  has_one :company_transaction, as: :transactable
  monetize :amount_cents, :allow_nil => false

  validates_presence_of :name, :expense_category, :added_by, :admin_user
end
