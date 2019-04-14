FactoryBot.define do
  factory :account do
    trait :user do
  	  username { Faker::Internet.username }
  	  sequence(:email) { |n| "bob#{n}@tamu.edu" }
      name { Faker::Name.name }
	  archived { false }
	  isAdmin{ false }
    end
	trait :archived_user do
  	  username { Faker::Internet.username }
  	  sequence(:email) { |n| "joe#{n}@tamu.edu" }
      name { Faker::Name.name }
	  archived { true }
	  isAdmin { false }
    end
    trait :admin do
    	username { Faker::Internet.username }
    	sequence(:email) { |n| "sam#{n}@tamu.edu" }
    	name { Faker::Name.name }
		archived { false }
		isAdmin { true }
    end
  end
end