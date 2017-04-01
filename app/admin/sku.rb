ActiveAdmin.register Sku do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
  permit_params :name,
                :pet_quantity


#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
  #
  form do |f|
    f.semantic_errors
    inputs do
      input :name
      input :pet_quantity
    end
    f.actions
  end
end
