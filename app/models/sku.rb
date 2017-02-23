class Sku < ApplicationRecord
  validates_presence_of :name, :quantity
  belongs_to :stock_in
  belongs_to :stock_out
end
