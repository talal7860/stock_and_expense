class CompanyTransaction < ApplicationRecord
  belongs_to :added_by, foreign_key: :added_by_id, class: "AdminUser"
  validates_presence_of :detail, :type_, :added_by
  monetize :amount, :allow_nil => true
end
