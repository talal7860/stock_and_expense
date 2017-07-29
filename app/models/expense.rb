class Expense < ApplicationRecord
  attr_accessor :expense_category_name
  belongs_to :expense_category
  belongs_to :added_by, foreign_key: :added_by_id, class_name: "AdminUser"
  belongs_to :admin_user
  has_one :company_transaction, as: :transactable, dependent: :destroy
  monetize :amount_cents, :allow_nil => false

  validates_presence_of :name, :expense_category_name, :added_by, :admin_user

  before_create :create_transaction
  before_update :update_transaction
  before_save :set_expense_category

  private

  def create_transaction
    self.company_transaction = CompanyTransaction.create!(
      transaction_type: :debit,
      amount_cents: self.amount_cents,
      detail: "Expense for Rs. #{self.amount} made by #{admin_user.name}",
      added_by: self.added_by
    )
  end

  def update_transaction
    if self.amount_cents_changed?
      company_transaction.update(
        amount_cents: self.amount_cents
      )
    end
  end

  def set_expense_category
    expense_category = ExpenseCategory.find_by_name(self.expense_category_name)
    if expense_category.present?
      self.expense_category = expense_category
    else
      self.expense_category = ExpenseCategory.create(name: expense_category_name)
    end
  end

end
