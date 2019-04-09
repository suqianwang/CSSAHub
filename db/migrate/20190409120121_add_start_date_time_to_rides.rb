class AddStartDateTimeToRides < ActiveRecord::Migration[5.2]
  def up
    add_column :rides, :start_datetime, :datetime
    add_column :rides, :end_datetime, :datetime

    Ride.all.each do |ride|
      ride.parse_datetime
      ride.save
    end
  end

  def down
    remove_column :rides, :start_datetime, :datetime
    remove_column :rides, :end_datetime, :datetime
  end
end
