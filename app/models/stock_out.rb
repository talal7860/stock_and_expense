class StockOut < ApplicationRecord
  belongs_to :added_by, foreign_key: :added_by_id, class_name: "AdminUser"
end
