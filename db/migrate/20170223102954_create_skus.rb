class CreateSkus < ActiveRecord::Migration[5.0]
  def change
    create_table :skus do |t|
      t.string :name
      t.integer :pet_quantity
      t.integer :remaining, default: 0

      t.timestamps
    end
  end
end
