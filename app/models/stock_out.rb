class StockOut < ApplicationRecord
  include Stockable

  belongs_to :customer
  validates_presence_of :customer
  after_destroy :add_stock
  after_create :remove_stock

  def transaction_detail
    "#{quantity} #{sku.name.pluralize(self.quantity * self.pet_quantity)} sold to #{customer.name}"
  end
  private

  def create_transaction
    self.company_transaction = CompanyTransaction.create!(
      transaction_type: :credit,
      amount_cents: self.amount_cents,
      detail: transaction_detail,
      added_by: self.added_by
    )
  end

  def update_stock
    if self.quantity_changed? || self.stock_unit_changed?
      sku.increment(:remaining, ((self.quantity_was * self.pet_quantity) - (self.quantity * self.pet_quantity))).save
    end
  end
end
