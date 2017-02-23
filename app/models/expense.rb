class Expense < ApplicationRecord
  belongs_to :expense_category
  belongs_to :added_by, foreign_key: :added_by_id, class: "AdminUser"
  validates_presence_of :name
  validates_presence_of :expense_category
end
