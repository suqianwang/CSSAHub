FactoryBot.define do
  factory :account do
    trait :user do
  	  username { Faker::Internet.username }
  	  sequence(:email) { |n| "bob#{n}@tamu.edu" }
      name { Faker::Name.name }
      password { Faker::Internet.password }
	  archived { false }
    end
	trait :archived_user do
  	  username { Faker::Internet.username }
  	  sequence(:email) { |n| "bob#{n}@tamu.edu" }
      name { Faker::Name.name }
      password { Faker::Internet.password }
	  archived { true }
    end
    trait :admin do
    	username { "admin" }
    	email { "admin@tamu.edu" }
    	name { "admin" }
    	password { "admin" }
    end
  end
end