class CreateStockOuts < ActiveRecord::Migration[5.0]
  def change
    create_table :stock_outs do |t|
      t.integer :quantity
      t.integer :customer_id
      t.integer :sku_id
      t.integer :added_by_id
      t.integer :stock_unit
      t.monetize :amount

      t.timestamps
    end
    add_index :stock_outs, :customer_id
    add_index :stock_outs, :sku_id
    add_index :stock_outs, :added_by_id
  end
end
