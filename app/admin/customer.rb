ActiveAdmin.register Customer do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
permit_params :name,
  :phone_number,
  :address

  form do |f|
    f.semantic_errors
    inputs do
      f.input :name
      f.input :phone_number
      f.input :address
    end
    f.actions
  end
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
  index do
    column :name
    column :phone_number
    column :amount_paid
    column :amount_due
    column :created_at
    column :updated_at
    actions
  end


end
