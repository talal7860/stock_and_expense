class StockOut < ApplicationRecord
  belongs_to :added_by, foreign_key: :added_by_id, class_name: "AdminUser"
  belongs_to :sku
  belongs_to :customer
  has_one :company_transaction, as: :transactable, dependent: :destroy

  validates_numericality_of :quantity, greater_than: 0
  validates_presence_of :added_by, :customer, :sku
  before_save :create_transaction
  after_create :remove_stock
  before_update :update_stock

  monetize :amount_cents, :numericality => {
    :greater_than_or_equal_to => 0
  }

  private

  def create_transaction
    self.company_transaction = CompanyTransaction.create!(
      transaction_type: :credit,
      amount_cents: (self.amount_cents * self.quantity),
      detail: "#{quantity} #{sku.name.pluralize(self.quantity)} sold to #{customer.name}",
      added_by: self.added_by
    )
  end

  def update_transaction
    if self.quantity_changed?
      company_transaction.update(
        amount_cents: self.amount_cents * self.quantity,
        detail: "#{quantity} #{sku.name.pluralize(self.quantity)} sold to #{customer.name}",
      )
    end
  end

  def remove_stock
    sku.decrement(:remaining, quantity * sku.quantity)
  end

  def update_stock
    if self.quantity_changed?
      sku.increment(:remaining, (self.quantity_was - self.quantity) * sku.quantity)
    end
  end
end
