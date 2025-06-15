class AddKycStatusToAccount < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :kyc_status, :integer, default: 0
  end
end
