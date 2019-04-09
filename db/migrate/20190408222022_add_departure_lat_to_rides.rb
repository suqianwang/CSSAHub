class AddDepartureLatToRides < ActiveRecord::Migration[5.2]
  def change
    add_column :rides, :departure_lat, :float
    add_column :rides, :departure_lon, :float
    add_column :rides, :destination_lat, :float
    add_column :rides, :destination_lon, :float
  end
end
