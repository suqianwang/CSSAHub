FactoryBot.define do
  factory :service do
    type { ['transportation'].sample }
    role { ['offerer', 'receiver'].sample }
  end
end