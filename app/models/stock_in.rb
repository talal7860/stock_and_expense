class StockIn < ApplicationRecord
  belongs_to :added_by, foreign_key: :added_by_id, class: "AdminUser"
end
