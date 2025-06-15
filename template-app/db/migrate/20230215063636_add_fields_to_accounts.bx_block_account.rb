class AddFieldsToAccounts < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :onfido_applicant_id, :string
    add_column :accounts, :onfido_check_id, :string
    add_column :accounts, :nationality, :string
    add_column :accounts, :date_of_birth, :string
    add_column :accounts, :middle_name, :string
    add_column :accounts, :gender, :string
  end
end
