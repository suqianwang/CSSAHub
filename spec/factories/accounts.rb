FactoryGirl.define do
  factory :account do
    username { Faker::Internet.username }
    email { Faker::Internet.email }
    name { Faker::Name.name }
    password { Faker::Internet.password }
  end
end