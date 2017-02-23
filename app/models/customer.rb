class Customer < ApplicationRecord
  has_many :stock_outs
  validates_presence_of :name, :phone_number, :address
end
