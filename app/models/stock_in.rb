class StockIn < ApplicationRecord
  belongs_to :added_by, foreign_key: :added_by_id, class_name: "AdminUser"
  belongs_to :sku
  belongs_to :client
  has_one :company_transaction, as: :transactable

  validates_numericality_of :quantity, greater_than: 0
  validates_presence_of :added_by, :client, :sku
  monetize :amount_cents, :numericality => {
    :greater_than_or_equal_to => 0
  }
end
