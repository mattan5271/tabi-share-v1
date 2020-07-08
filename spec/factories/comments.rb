Faker::Config.locale = :ja

FactoryBot.define do
  factory :comment do
    title { Faker::Lorem.characters(number: 10) }
    body { Faker::Lorem.characters(number: 10) }
  end
end