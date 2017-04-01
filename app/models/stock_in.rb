class StockIn < ApplicationRecord
  include Stockable

  belongs_to :client
  validates_presence_of :client
  after_create :add_stock
  after_destroy :remove_stock

  private

  def transaction_detail
    "#{quantity} #{sku.name.pluralize(self.quantity * self.pet_quantity)} bought from #{client.name}"
  end

  def create_transaction
    if self.company_transaction.nil?
      self.company_transaction = CompanyTransaction.create!(
        transaction_type: :debit,
        amount_cents: self.amount_cents,
        detail: transaction_detail,
        added_by: self.added_by
      )
    end
  end

  def update_stock
    if self.quantity_changed? || self.stock_unit_changed?
      sku.decrement(:remaining, ((self.quantity_was * self.pet_quantity) - (self.quantity * self.pet_quantity))).save
    end
  end


end
