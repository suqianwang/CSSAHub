class AddFieldsToRide < ActiveRecord::Migration[5.2]
  def change
    add_reference :rides, :account, foreign_key: true
    add_column :rides, :departure, :string
    add_column :rides, :destination, :string
    add_column :rides, :start_date, :string
    add_column :rides, :end_date, :string
    add_column :rides, :start_time, :string
    add_column :rides, :end_time, :string
    add_column :rides, :seats, :integer
  end
end
