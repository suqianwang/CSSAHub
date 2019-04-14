class AddIsAdminToAccounts < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :isAdmin, :boolean, default: false
  end
end
