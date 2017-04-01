module Stockable
  extend ActiveSupport::Concern
  included do
    belongs_to :added_by, foreign_key: :added_by_id, class_name: "AdminUser"
    belongs_to :sku
    has_one :company_transaction, as: :transactable, dependent: :destroy

    validates_numericality_of :quantity, greater_than: 0
    validates_presence_of :added_by, :sku
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
  end

  def pet_quantity
    if self.stock_unit == 'single'
      1
    elsif self.stock_unit == 'pet'
      sku.pet_qunatity || 1
    end
  end

  def remove_stock
    sku.decrement(:remaining, self.quantity).save
  end

  def add_stock
    sku.increment(:remaining, quantity * self.pet_quantity).save
  end

end
