class StockOut < ApplicationRecord
  include Stockable

  belongs_to :customer
  validates_presence_of :customer
  after_destroy :add_stock
  after_create :remove_stock

  private

  def create_transaction
    self.company_transaction = CompanyTransaction.create!(
      transaction_type: :credit,
      amount_cents: self.amount_cents,
      detail: "#{quantity} #{sku.name.pluralize(self.quantity)} sold to #{customer.name}",
      added_by: self.added_by
    )
  end

  def update_transaction
    if self.quantity_changed? || self.amount_cents_changed?
      company_transaction.update(
        amount_cents: self.amount_cents,
        detail: "#{quantity} #{sku.name.pluralize(self.quantity)} sold to #{customer.name}",
      )
    end
  end

  def remove_stock
    sku.decrement(:remaining, quantity).save
  end

  def update_stock
    if self.quantity_changed?
      sku.increment(:remaining, (self.quantity_was - self.quantity)).save
    end
  end
end
