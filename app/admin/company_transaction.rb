ActiveAdmin.register CompanyTransaction do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
permit_params :detail,
  :amount,
  :transaction_type

  form do |f|
    f.semantic_errors
    inputs do
      f.input :detail
      f.input :amount
      f.input :transaction_type
    end
    f.actions
  end

  index do
    column :detail
    column :added_by
    column :transaction_type
    column :amount do |company_transaction|
      humanized_money_with_symbol company_transaction.amount
    end
    column :created_at
    column :updated_at
    actions
  end


end
