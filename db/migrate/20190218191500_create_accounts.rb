class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.string :email
      t.string :username
      t.string :name
      t.string :password

      t.timestamps
    end
  end
end
