class Client < ApplicationRecord
  has_many :stock_ins
  validates_presence_of :name, :phone_number, :address
end
