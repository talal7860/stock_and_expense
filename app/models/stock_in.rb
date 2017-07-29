class StockIn < ApplicationRecord
  include Stockable

  belongs_to :client
  validates_presence_of :client
  after_create :add_stock
  after_destroy :remove_stock
  after_create :add_client_amount
  after_update :update_client_amount

  private

  def transaction_detail
    "#{quantity} #{sku.name.pluralize(self.quantity * self.pet_quantity)} bought from #{client.name}"
  end

  def create_transaction
    if self.company_transaction.nil?
      self.company_transaction = CompanyTransaction.create!(
        transaction_type: :debit,
        amount_cents: self.amount_paid_cents,
        detail: transaction_detail,
        added_by: self.added_by
      )
    end
  end

  def add_client_amount
    add_person_amount(client)
    #client.increment(:amount_paid_cents, self.amount_paid_cents)
    #client.decrement(:amount_due_cents, self.amount_cents - self.amount_paid_cents)
  end

  def update_client_amount
    update_person_amount(client)
    #if self.amount_paid_cents_changed? || self.amount_cents_was_changed?
      #client.decrement(:amount_paid_cents, self.amount_paid_cents_was)
      #client.increment(:amount_paid_cents, self.amount_paid_cents)
      #client.increment(:amount_due_cents, self.amount_cents_was - self.amount_paid_cents_was)
     # client.decrement(:amount_due_cents, self.amount_cents_was - self.amount_paid_cents_was)
    #end
  end

  def update_stock
    if self.quantity_changed? || self.stock_unit_changed?
      sku.decrement(:remaining, ((self.quantity_was * self.pet_quantity) - (self.quantity * self.pet_quantity))).save
    end
  end


end
