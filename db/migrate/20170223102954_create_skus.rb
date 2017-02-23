class CreateSkus < ActiveRecord::Migration[5.0]
  def change
    create_table :skus do |t|
      t.string :name
      t.integer :quantity

      t.timestamps
    end
  end
end
