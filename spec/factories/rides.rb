FactoryBot.define do
  factory :ride do
    association :account, :user
	account_id { 1 }
    role { ['driver', 'passenger'].sample }
    departure { ['Zachry Engineering Center, Spence Street, College Station, TX, USA', 'George Bush Intercontinental Airport (IAH), North Terminal Road, Houston, TX, USA'].sample }
    destination { ['Zachry Engineering Center, Spence Street, College Station, TX, USA', 'George Bush Intercontinental Airport (IAH), North Terminal Road, Houston, TX, USA'].sample }
    start_date { (Date.today+6).strftime('%m/%d/%Y') }
    end_date { (Date.today+7).strftime('%m/%d/%Y') }
    start_time { "11:00" }
    end_time { "12:00" }
    seats { Faker::Number.between(1, 8) }
  end
end