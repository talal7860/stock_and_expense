class CreateCompanyTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :company_transactions do |t|
      t.string :detail
      t.string :type_
      t.integer :amount_cents
      t.integer :added_by_id

      t.timestamps
    end
    add_index :company_transactions, :added_by_id
  end
end
