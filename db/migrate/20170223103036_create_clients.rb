class CreateClients < ActiveRecord::Migration[5.0]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :phone_number
      t.text :address
      t.monetize :amount_paid, default: 0
      t.monetize :amount_due, default: 0

      t.timestamps
    end
  end
end
