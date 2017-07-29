class CreateStockIns < ActiveRecord::Migration[5.0]
  def change
    create_table :stock_ins do |t|
      t.integer :sku_id
      t.integer :quantity
      t.integer :client_id
      t.integer :added_by_id
      t.monetize :amount
      t.monetize :amount_paid
      t.integer :stock_unit
      t.date :manufacture_date
      t.date :expiry_date

      t.timestamps
    end
    add_index :stock_ins, :added_by_id
    add_index :stock_ins, :sku_id
    add_index :stock_ins, :client_id
  end
end
