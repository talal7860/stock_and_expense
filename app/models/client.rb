class Client < ApplicationRecord
  has_many :stock_ins
  validates_presence_of :name, :phone_number, :address
  validates_uniqueness_of :phone_number
  phony_normalize :phone_number, default_country_code: 'PK'
  monetize :amount_paid_cents
  monetize :amount_due_cents
end
