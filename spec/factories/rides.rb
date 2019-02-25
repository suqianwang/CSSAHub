FactoryGirl.define do
  factory :ride do
    role { ['driver', 'passenger'].sample }
  end
end