ActiveAdmin.register StockIn do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
  permit_params :added_by_id,
                :sku_id,
                :stock_unit,
                :manufacture_date,
                :expiry_date,
                :client_id,
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
      f.input :client_id, label: 'Client', as: :select, collection: Client.all.map{|c| [c.name, c.id]}
      f.input :manufacture_date, as: :datepicker, datepicker_options: { max_date: Date.today }
      f.input :expiry_date, as: :datepicker
    end
    f.actions
  end

  index do
    column :quantity do |sku_in|
      if sku_in.stock_unit == 'pet'
        quantity / sku_in.sku.pet_quantity
      elsif sku_in.stock_unit == 'single'
        quantity
      end
    end
    column :amount
    column :amount_paid
    column :expiry_date
    column :added_by
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
