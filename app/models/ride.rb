require 'pry'

class Ride < ApplicationRecord
  belongs_to :account
  validates :role, presence: true, inclusion: { in: ['driver', 'passenger'] }
  validates :departure, presence: { message: "Please select a valid departure location from Google map"}
  validates :destination, presence: { message: "Please select a valid destination location from Google map"}
  validates :start_date, presence: { message: "Please select a valid departure date"}, :timeliness => { :on_or_after => :today, :type => :date }
  validates :start_time, presence:{ message: "Please enter departure start time in correct format, (i.e. 07:00)"}, :timeliness => { :type => :time }
  validates :end_time, presence: { message: "Please enter a valid departure time that is on or after departure start time in correct format(i.e. 07:00)"}, :timeliness => { :on_or_after => :start_time, :type => :time }
  validates :seats, presence: true, inclusion: { in: 1..8 }

  before_save :override_field
  after_validation :geocode_departure, if: ->(obj){ obj.departure.present? and obj.departure_changed? }
  after_validation :geocode_destination, if: ->(obj){ obj.destination.present? and obj.destination_changed? }

  def start_date=(value)
    value = Date.strptime(value, '%m/%d/%Y') rescue value
    super(value)
  end

  def end_date=(value)
    value = Date.strptime(value, "%m/%d/%Y") rescue value
    super(value)
  end

  def self.all_types
    %w(driver passenger)
  end

  def parse_datetime
    self.start_datetime = Timeliness.parse("#{self.start_date} #{self.start_time}")
    self.end_datetime = Timeliness.parse("#{self.end_date} #{self.end_time}")
  end

  private

  def geocode_departure
    g = Geocoder.search(self.departure)
    self.departure_lat, self.departure_lon = g.first.coordinates
  end

  def geocode_destination
    self.destination_lat, self.destination_lon = Geocoder.search(self.destination).first.coordinates
  end


  def override_field
    if self.end_date.nil?
      self.end_date = self.start_date
    end
    self.parse_datetime
  end


  def self.departure_in_range(location_1, location_2, range) #check if location_2 is location_1's circle with a custom radius
    point1 = [location_1.departure_lat,location_1.departure_lon]
    point2 = [location_2.departure_lat,location_2.departure_lon]
    return Geocoder::Calculations.distance_between(point1, point2) <= range
  end

  def self.destination_in_range(location_1, location_2, range) #check if location_2 is location_1's circle with a custom radius
    point1 = [location_1.destination_lat,location_1.destination_lon]
    point2 = [location_2.destination_lat,location_2.destination_lon]
    return Geocoder::Calculations.distance_between(point1, point2) <= range
  end

  def self.match_ride(id) #    @ride = Ride.find(params[:id])
    @ride = Ride.find(id)
    @matched_rides = Array.new
    Ride.all.each do |potential_match|
      #role show, capacity show
      if potential_match == @ride || @ride.role == potential_match.role
        next
      end
      if @ride.role == 'driver' && potential_match.seats > @ride.seats
        next
      end
      if @ride.role == 'passenger' && potential_match.seats < @ride.seats
        next
      end

      match = {
          :departure => Ride.departure_in_range(potential_match, @ride, 1),
          :destination => Ride.destination_in_range(potential_match, @ride, 1),
          :date => @ride.start_date == potential_match.start_date,
          :time => @ride.start_time <= potential_match.end_time && potential_match.start_time <= @ride.end_time
      }


      if match.values.all?()
        @matched_rides.push(potential_match)
      end
    end
    return @matched_rides
  end

end