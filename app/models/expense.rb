class Expense < ApplicationRecord
  attr_accessor :expense_category_name
  belongs_to :expense_category
  belongs_to :added_by, foreign_key: :added_by_id, class_name: "AdminUser"
  belongs_to :admin_user
  has_one :company_transaction, as: :transactable, dependent: :destroy
  monetize :amount_cents, :allow_nil => false

  validates_presence_of :name, :expense_category, :added_by, :admin_user

  before_create :create_transaction
  before_update :update_transaction

  private

  def create_transaction
    self.company_transaction = CompanyTransaction.create!(
      transaction_type: :credit,
      amount_cents: self.amount_cents,
      detail: "Expense for #{self.amount_cents} made by #{admin_user.name}",
      added_by: self.added_by
    )
  end

  def update_transaction
    if self.quantity_changed?
      company_transaction.update(
        amount_cents: self.amount_cents,
        detail: "Expense for #{self.amount_cents} made by #{admin_user.name}",
      )
    end
  end
end
