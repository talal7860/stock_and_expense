class CreateCompanyTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :company_transactions do |t|
      t.string :detail
      t.integer :transaction_type
      t.monetize :amount
      t.integer :added_by_id
      t.references :transactable, polymorphic: true, index: false

      t.timestamps
    end
    add_index :company_transactions, :added_by_id
  end
end
