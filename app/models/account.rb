class Account < ApplicationRecord
  has_many :rides
  has_secure_password
  
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true
  validates :terms_and_conditions, acceptance: true

end
