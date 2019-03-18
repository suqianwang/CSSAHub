FactoryBot.define do
  factory :account do
  trait :user do
	username { Faker::Internet.username }
	email { Faker::Internet.email }
    name { Faker::Name.name }
    password { Faker::Internet.password }
  end
  trait :admin do
	username { "admin" }
	email { "admin" }
	name { "admin" }
	password { "admin" }
  end
  end
end