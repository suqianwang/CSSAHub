require 'pry'

class Ride < ApplicationRecord
  belongs_to :account
  validates :role, presence: true, inclusion: { in: ['driver', 'passenger'] }
  validates :departure, presence: true, inclusion: { in: ['Zachry', 'HEB', 'IAH', 'DPS', 'Rec', 'Walmart'] }
  validates :destination, presence: true, inclusion: { in: ['Zachry', 'HEB', 'IAH', 'DPS', 'Rec', 'Walmart'] }
  validates :start_date, presence: true, :timeliness => { :after => :today, :type => :date }
  validates :end_date, presence: true, :timeliness => { :on_or_after => :start_date, :type => :date }
  validates :start_time, presence: true, :timeliness => { :type => :time }
  validates :end_time, presence: true, :timeliness => { :after => :start_time, :type => :time }
  validates :seats, presence: true, inclusion: { in: 1..8 }
  
  def start_date=(value)
    if not value.blank?
      value = Date.strptime(value, '%Y-%m-%d')
      super(value)
    end
  end
  def end_date=(value)
    if not value.blank?
      value = Date.strptime(value, "%Y-%m-%d")
      super(value)
    end
  end
  def start_time=(value)
    # binding.pry
    if not value.blank?
      value = Time.zone.strptime(value, "%H:%M")
      super(value)
    end
  end
  def end_time=(value)
    if not value.blank?
      value = Time.zone.strptime(value, "%H:%M")
      super(value)
    end
  end
end