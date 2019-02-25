class Ride < ApplicationRecord
  validates_presence_of :role
  validates_inclusion_of :role, :in => ['driver', 'passenger']
end