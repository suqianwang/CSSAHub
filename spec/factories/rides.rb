FactoryBot.define do
  factory :ride do
    association :account, :user
	account_id { 1 }
    role { ['driver', 'passenger'].sample }
    departure { ['Zachry', 'HEB', 'IAH', 'Walmart', 'DPS', 'Rec'].sample }
    destination { ['Zachry', 'HEB', 'IAH', 'Walmart', 'DPS', 'Rec'].sample }
    start_date { Date.today+5.days }
    end_date { Date.today+10.days }
    start_time { "11:00" }
    end_time { "12:00" }
    seats { Faker::Number.between(1, 8) }
  end
end