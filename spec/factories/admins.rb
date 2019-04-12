FactoryBot.define do
  factory :admin do
	username { "admin" }
	email { "admin" }
	name { "admin" }
	password { "admin" }
	isAdmin { true }
  end
end