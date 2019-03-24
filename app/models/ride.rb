class Ride < ApplicationRecord
  belongs_to :account
  validates :role, presence: true, inclusion: { in: ['driver', 'passenger'] }
  validates :departure, presence: true, inclusion: { in: ['Zachry', 'HEB', 'IAH', 'DPS', 'Rec', 'Walmart'] }
  validates :destination, presence: true, inclusion: { in: ['Zachry', 'HEB', 'IAH', 'DPS', 'Rec', 'Walmart'] }
  validates_presence_of :start_date, :end_date, :start_time, :end_time
  validates :seats, presence: true, inclusion: { in: 1..8 }
end