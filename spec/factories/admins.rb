FactoryBot.define do
  factory :admin do
	username { "admin" }
	email { "admin@tamu.edu" }
	name { "admin" }
	isAdmin { true }
  end
end