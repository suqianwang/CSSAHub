FactoryBot.define do
  factory :ride do
    association :account, :user
    role { ['driver', 'passenger'].sample }
    departure { ['Zachry', 'HEB', 'IAH', 'Walmart', 'DPS', 'Rec'].sample }
    destination { ['Zachry', 'HEB', 'IAH', 'Walmart', 'DPS', 'Rec'].sample }
    start_date { Date.today+1 }
    end_date { Date.today+2 }
    start_time { Time.current }
    end_time { Time.current+60 }
    seats { Faker::Number.between(1, 8) }
  end
end