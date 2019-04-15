class Account < ApplicationRecord
  has_many :rides
  
  validates :email, presence: true, format: { with: /\A\S+@tamu.edu\z/, message: "must be tamu email" }, uniqueness: true
  validates :username, presence: true
  
  def self.from_omniauth(auth)
    if account = Account.find_by_email(auth.info.email)
      account
    else
      account = Account.create(username: auth.info.name, email: auth.info.email)
      account.save
      account
    end
  end
end

