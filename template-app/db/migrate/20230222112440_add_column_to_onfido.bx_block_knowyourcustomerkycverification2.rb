class AddColumnToOnfido < ActiveRecord::Migration[6.0]
  def change
    add_column :bx_block_knowyourcustomerkycverification2_onfidos, :onfido_applicant_id, :string
    add_column :bx_block_knowyourcustomerkycverification2_onfidos, :onfido_check_id, :string
    add_column :bx_block_knowyourcustomerkycverification2_onfidos, :onfido_report_id, :string
    add_column :bx_block_knowyourcustomerkycverification2_onfidos, :kyc_status, :integer, default: 0
    add_column :bx_block_knowyourcustomerkycverification2_onfidos, :reports_status, :string
    add_column :bx_block_knowyourcustomerkycverification2_onfidos, :email, :string
  end
end
