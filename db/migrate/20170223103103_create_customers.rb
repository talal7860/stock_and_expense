class CreateCustomers < ActiveRecord::Migration[5.0]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :phone_number
      t.text :address
      t.monetize :amount_paid
      t.monetize :amount_due

      t.timestamps
    end
  end
end
