require 'pry'

class Ride < ApplicationRecord
  belongs_to :account
  validates :role, presence: true, inclusion: { in: ['driver', 'passenger'] }
  validates :departure, presence: true
  validates :destination, presence: true
  validates :start_date, presence: true, :timeliness => { :on_or_after => :today, :type => :date }
  validates :end_date, presence: true, :timeliness => { :on_or_after => :start_date, :type => :date }
  validates :start_time, presence: true, :timeliness => { :type => :time }
  validates :end_time, presence: true, :timeliness => { :on_or_after => :start_time, :type => :time }
  validates :seats, presence: true, inclusion: { in: 1..8 }

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
          :departure => potential_match.departure == @ride.departure,
          :destination => potential_match.destination == @ride.destination,
          :date => @ride.start_date <= potential_match.end_date && potential_match.start_date <= @ride.end_date,
          :time => @ride.start_time <= potential_match.end_time && potential_match.start_time <= @ride.end_time
      }


      if match.values.all?()
        @matched_rides.push(potential_match)
      end
    end
    return @matched_rides
  end
end