Faker::Config.locale = :ja

FactoryBot.define do
  factory :event do
    title { Faker::Lorem.characters(number: 10) }
    body { Faker::Lorem.characters(number: 10) }
    start_date { '2020-07-01 23:59:60 +0000' }
    end_date { '2020-07-01 23:59:60 +0000' }
  end
end