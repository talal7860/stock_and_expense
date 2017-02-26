class CreateExpenseCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :expense_categories do |t|
      t.string :name
      t.string :slug

      t.timestamps
    end
    add_index :expense_categories, :slug
  end
end
