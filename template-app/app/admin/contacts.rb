ActiveAdmin.register BxBlockContactUs::Contact, as: "Contacts" do
  permit_params :name, :email, :phone_number, :description
end
