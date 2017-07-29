ActiveAdmin.register StockOut do

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
                :sku_id,
                :stock_unit,
                :customer_id,
                :quantity,
                :amount,
                :amount_paid


  form do |f|
    f.semantic_errors
    f.object.added_by_id = current_admin_user.id if f.object.added_by_id.nil?
    inputs do
      f.input :added_by_id, as: :hidden
      f.input :sku_id, label: 'Sku', as: :select, collection: Sku.all.map{|c| [c.name, c.id]}
      f.input :stock_unit
      f.input :quantity
      f.input :amount
      f.input :amount_paid
      f.input :customer_id, label: 'Customer', as: :select, collection: Customer.all.map{|c| [c.name, c.id]}
    end
    f.actions
  end


end
