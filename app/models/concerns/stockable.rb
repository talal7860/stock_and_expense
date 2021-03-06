module Stockable
  extend ActiveSupport::Concern
  included do
    belongs_to :added_by, foreign_key: :added_by_id, class_name: "AdminUser"
    belongs_to :sku
    has_one :company_transaction, as: :transactable, dependent: :destroy

    validates_numericality_of :quantity, greater_than_or_equal_to: 0
    validates_presence_of :added_by, :sku, :stock_unit
    before_save :create_transaction
    before_update :update_stock
    after_update :update_transaction
    enum stock_unit: [
      :single,
      :pet
    ]

    monetize :amount_cents, :numericality => {
      :greater_than_or_equal_to => 0
    }
    monetize :amount_paid_cents, :numericality => {
      :greater_than_or_equal_to => 0
    }
  end

  def pet_quantity
    if self.stock_unit == 'single'
      1
    elsif self.stock_unit == 'pet'
      sku.pet_quantity || 1
    end
  end

  def remove_stock
    sku.decrement(:remaining, self.quantity * self.pet_quantity).save
  end

  def add_stock
    sku.increment(:remaining, quantity * self.pet_quantity).save
  end

  def update_transaction
    if self.amount_cents_changed? || self.stock_unit_changed?
      company_transaction.update(
        amount_cents: self.amount_paid_cents,
        detail: transaction_detail
      )
    end
  end

  def add_person_amount(person)
    person.increment(:amount_paid_cents, self.amount_paid_cents)
    person.increment(:amount_due_cents, self.amount_cents - self.amount_paid_cents)
  end

  def update_person_amount(person)
    if self.amount_paid_cents_changed? || self.amount_cents_changed?
      person.decrement(:amount_paid_cents, self.amount_paid_cents_was)
      person.increment(:amount_paid_cents, self.amount_paid_cents)
      person.decrement(:amount_due_cents, self.amount_cents_was - self.amount_paid_cents_was)
      person.increment(:amount_due_cents, self.amount_cents_was - self.amount_paid_cents_was)
    end
  end

end
