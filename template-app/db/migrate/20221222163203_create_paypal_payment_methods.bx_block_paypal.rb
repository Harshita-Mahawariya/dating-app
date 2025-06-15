# This migration comes from bx_block_paypal (originally 20200930111845)
class CreatePaypalPaymentMethods < ActiveRecord::Migration[6.0]
  def change
    create_table :bx_block_paypal_payment_methods do |t|
      t.string :slug
      t.string :client_id
      t.string :client_secret
      t.timestamps
    end
  end
end
