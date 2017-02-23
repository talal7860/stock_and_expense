class CreateCompanyWallets < ActiveRecord::Migration[5.0]
  def change
    create_table :company_wallets do |t|
      t.string :detail
      t.integer :amount_cents
      t.integer :added_by_id

      t.timestamps
    end
    add_index :company_wallets, :added_by_id
  end
end
