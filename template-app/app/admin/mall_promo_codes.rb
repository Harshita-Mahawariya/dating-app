module MallPromoCodes
end
ActiveAdmin.register BxBlockPromoCodes::MallPromoCode do
# ActiveAdmin.register BxBlockPromoCodes::MallPromoCode, :as => "Static" do
# ActiveAdmin.register BxBlockPromoCodes::MallPromoCode, as: "Static" do

  # menu label: "Mall Promo Code"
  # index :title => "Mall Promo Code"
  # breadcrumb do
  #   ['admin', 'Mall Promo Code']
  # end
  permit_params :promo_code_id, :mall_id

  form do |f|
    f.inputs do
      f.input :promo_code
      f.input :mall_id
    end
    f.actions
  end
end
