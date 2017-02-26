class CompanyWallet < ApplicationRecord
  belongs_to :added_by, foreign_key: :added_by_id, class_name: "AdminUser"
  belongs_to :transactable, polymorphic: true

  validates_presence_of :detail, :added_by
  monetize :amount_cents, :allow_nil => false
end
