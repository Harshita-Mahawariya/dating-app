ActiveAdmin.register BxBlockPrivacySettings::PrivacyPolicy, as: "Privacy Policy" do
  permit_params :description
end
