ActiveAdmin.register Expense do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

permit_params :added_by_id,
  :expense_category_name,
  :admin_user_id,
  :name,
  :amount

  form do |f|
    f.semantic_errors
    f.object.added_by_id = current_admin_user.id if f.object.added_by_id.nil?
    inputs do
      f.input :added_by_id, as: :hidden
      f.input :expense_category_name
      f.input :admin_user, label: "Responsible Person"
      f.input :name
      f.input :amount
    end
    f.actions
  end

  index do
    column :name
    column :amount do |instance|
      humanized_money_with_symbol instance.amount
    end
    column :expense_category
    column :added_by
    column :admin_user
    column :created_at
    column :updated_at
    actions
  end

end
