FactoryBot.define do
  factory :ride do
    :account
    role { ['driver', 'passenger'].sample }
    departure { ['Zachry', 'HEB', 'IAH', 'Walmart', 'DPS', 'Rec'].sample }
    destination { ['Zachry', 'HEB', 'IAH', 'Walmart', 'DPS', 'Rec'].sample }
    start_date { Faker::Date.between(1.days.from_now, 10.days.from_now) }
    end_date { Faker::Date.between(start_date, 10.days.from_now) }
    start_time { '07:03:30' }
    end_time { '06:12:09' }
    seats { Faker::Number.between(1, 8) }
  end
end