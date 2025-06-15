# This migration comes from bx_block_paypal (originally 20200930111941)
class CreatePaypalOrderTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :bx_block_paypal_order_transactions do |t|
      t.references :order, null: false, foreign_key: {to_table: :bx_block_paypal_orders}
      t.references :payment_method, null: false, foreign_key: {to_table: :bx_block_paypal_orders}
      t.string :state, default: 'pending'
      t.string :payment_reference_id
      t.string :payment_capture_id
      t.string :payment_refund_id
      t.timestamps
    end
  end
end
