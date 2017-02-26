class Sku < ApplicationRecord
  has_many :stock_ins
  has_many :stock_outs

  validates_presence_of :name
  validates_numericality_of :quantity, greater_than: 0
  validates_numericality_of :remaining
end
