class DepartFrom < ActiveRecord::Migration[5.2]
  def change
      add_column :rides, :depart_from, :string
  end
end
