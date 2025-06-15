module PromoCodes
end

ActiveAdmin.register BxBlockPromoCodes::PromoCode do
  # menu label: "Promo Code"
  # index :title => "Promo Code"
  permit_params :name, :discount_type, :redeem_limit, :description, :terms_n_condition,
                :max_discount_amount, :min_order_amount, :from, :to, :status, :discount
end
