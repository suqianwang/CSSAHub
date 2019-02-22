class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.string :username
      t.string :email
      t.string :name
      t.string :password_digest

      t.timestamps
    end
    add_index :accounts, :username, unique: true
    add_index :accounts, :email, unique: true
  end
end
