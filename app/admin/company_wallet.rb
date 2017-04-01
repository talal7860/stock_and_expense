ActiveAdmin.register CompanyWallet do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
permit_params :added_by_id,
  :detail,
  :amount

  form do |f|
    f.semantic_errors
    f.object.added_by_id = current_admin_user.id if f.object.added_by_id.nil?
    inputs do
      f.input :added_by_id, as: :hidden
      f.input :detail
      f.input :amount
    end
    f.actions
  end

  index do
    column :detail
    column :added_by
    column :amount do |company_wallet|
      humanized_money_with_symbol company_wallet.amount
    end
    column :created_at
    column :updated_at
    actions
  end
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end


end
