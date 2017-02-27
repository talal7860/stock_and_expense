class StockIn < ApplicationRecord
  belongs_to :added_by, foreign_key: :added_by_id, class_name: "AdminUser"
  belongs_to :sku
  belongs_to :client
  has_one :company_transaction, as: :transactable, dependent: :destroy

  validates_numericality_of :quantity, greater_than: 0
  validates_presence_of :added_by, :client, :sku
  monetize :amount_cents, :numericality => {
    :greater_than_or_equal_to => 0
  }
  before_save :create_transaction
  before_create :add_stock
  before_update :update_stock
  before_update :update_transaction
  after_destroy :remove_stocks

  private

  def create_transaction
    if self.company_transaction.nil?
      self.company_transaction = CompanyTransaction.create!(
        transaction_type: :debit,
        amount_cents: (self.amount_cents * self.quantity),
        detail: "#{quantity} #{sku.name.pluralize(self.quantity)} bought from #{client.name}",
        added_by: self.added_by
      )
    end
  end

  private

  def add_stock
    sku.increment(:remaining, quantity * sku.quantity)
  end

  def update_stock
    if self.quantity_changed?
      sku.decrement(:remaining, (self.quantity_was - self.quantity) * sku.quantity)
    end
  end

  def update_transaction
    if self.quantity_changed?
      company_transaction.update(
        amount_cents: self.amount_cents * self.quantity,
        detail: "#{quantity} #{sku.name.pluralize(self.quantity)} bought from #{client.name}",
      )
    end
  end

  def remove_stocks
    sku.decrement(:remaining, self.quantity * sku.quantity)
  end

end
