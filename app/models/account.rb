class Account < ApplicationRecord
  has_secure_password
  
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :username, presence: true
  validates :username, uniqueness: true
  validates :password, presence: true
end
