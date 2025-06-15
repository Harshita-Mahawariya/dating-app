# This migration comes from bx_block_paypal (originally 20200930111220)
class CreatePaypalOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :bx_block_paypal_orders do |t|
      t.float :total
      t.timestamps
    end
  end
end
