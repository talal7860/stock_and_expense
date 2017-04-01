class Customer < ApplicationRecord
  has_many :stock_outs
  validates_presence_of :name, :phone_number, :address
  validates_uniqueness_of :phone_number
  phony_normalize :phone_number, default_country_code: 'PK'
end
