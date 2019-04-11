# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

accounts = [{:username => 'admin', :email => 'admin@tamu.edu', :password => "admin", :isAdmin => true}
  	 ]

accounts.each do |account|
  Account.create!(account)
end
