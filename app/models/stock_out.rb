class StockOut < ApplicationRecord
  include Stockable

  belongs_to :customer
  validates_presence_of :customer
  after_destroy :add_stock
  after_create :remove_stock
  #after_save :update_customer
  after_create :add_customer_amount
  after_update :update_customer_amount

  def transaction_detail
    "#{quantity} #{sku.name.pluralize(self.quantity * self.pet_quantity)} sold to #{customer.name}"
  end
  private

  def create_transaction
    self.company_transaction = CompanyTransaction.create!(
      transaction_type: :credit,
      amount_cents: self.amount_paid_cents,
      detail: transaction_detail,
      added_by: self.added_by
    )
  end

  #def update_customer
    #customer.increment(:amount_paid_cents, self.amount_paid_cents)
    #customer.decrement(:amount_due_cents, self.amount_cents - self.amount_paid_cents)
  #end

  def add_customer_amount
    add_person_amount(customer)
    #client.increment(:amount_paid_cents, self.amount_paid_cents)
    #client.decrement(:amount_due_cents, self.amount_cents - self.amount_paid_cents)
  end

  def update_customer_amount
    update_person_amount(customer)
    #if self.amount_paid_cents_changed? || self.amount_cents_was_changed?
      #client.decrement(:amount_paid_cents, self.amount_paid_cents_was)
      #client.increment(:amount_paid_cents, self.amount_paid_cents)
      #client.increment(:amount_due_cents, self.amount_cents_was - self.amount_paid_cents_was)
      #client.decrement(:amount_due_cents, self.amount_cents_was - self.amount_paid_cents_was)
    #end
  end

  def update_stock
    if self.quantity_changed? || self.stock_unit_changed?
      sku.increment(:remaining, ((self.quantity_was * self.pet_quantity) - (self.quantity * self.pet_quantity))).save
    end
  end
end
