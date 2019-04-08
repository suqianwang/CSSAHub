json.extract! ride, :id, :departure, :destination, :start_date, :end_date, :start_time, :end_time, :seats, :created_at, :updated_at
json.url ride_url(ride, format: :json)