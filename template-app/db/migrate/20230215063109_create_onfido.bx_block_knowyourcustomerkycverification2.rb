class CreateOnfido < ActiveRecord::Migration[6.0]
  def change
    create_table :bx_block_knowyourcustomerkycverification2_onfidos do |t|
      t.string :document_type
    end
  end
end
