ActiveAdmin.register Item do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :name, :description, :price, :stock, :percentage_off, :image, :icon
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
form :html => { :enctype => "multipart/form-data" } do |f|
   f.inputs "Details" do
    f.input :name
    f.input :description
    f.input :price
    f.input :stock
    f.input :percentage_off
    f.input :icon#, :as => :file
    #f.input :icon, :as => :file, :hint => f.template.image_tag(f.object.image.url(:medium))
  end
  f.actions
 end

end
