FactoryBot.define do
  factory :ride do
    association :account, :user
    role { ['driver', 'passenger'].sample }
    departure { ['Zachry', 'HEB', 'IAH', 'Walmart', 'DPS', 'Rec'].sample }
    destination { ['Zachry', 'HEB', 'IAH', 'Walmart', 'DPS', 'Rec'].sample }
    start_date { (Date.today+1).to_s }
    end_date { (Date.today+2).to_s }
    start_time { '8:00' }
    end_time { '12:00' }
    seats { Faker::Number.between(1, 8) }
  end
end