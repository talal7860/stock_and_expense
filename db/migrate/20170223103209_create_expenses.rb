class CreateExpenses < ActiveRecord::Migration[5.0]
  def change
    create_table :expenses do |t|
      t.string :name
      t.integer :added_by_id
      t.integer :expense_category_id
      t.integer :admin_user_id
      t.integer :amount_cents

      t.timestamps
    end
    add_index :expenses, :expense_category_id
    add_index :expenses, :admin_user_id
  end
end
