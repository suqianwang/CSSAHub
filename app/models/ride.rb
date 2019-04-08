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

  def self.all_types
    %w(driver passenger)
  end
end