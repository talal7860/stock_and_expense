class StockOut < ApplicationRecord
  belongs_to :added_by, foreign_key: :added_by_id, class_name: "AdminUser"
  belongs_to :sku
  belongs_to :customer
  has_one :company_transaction, as: :transactable

  validates_numericality_of :quantity, greater_than: 0
  validates_presence_of :added_by, :customer, :sku
  before_save :create_transaction

  monetize :amount_cents, :numericality => {
    :greater_than_or_equal_to => 0
  }

  private

  def create_transaction
    if self.company_transaction.nil?
      self.company_transaction = CompanyTransaction.create!(
        transaction_type: :credit,
        amount_cents: (self.amount_cents * self.quantity),
        detail: "#{quantity} #{sku.name.pluralize(self.quantity)} sold to #{customer.name}",
        added_by: self.added_by
      )
    end
  end
end
