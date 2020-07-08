require 'json'
Faker::Config.locale = :ja

FactoryBot.define do
  factory :room do
    name { Faker::Lorem.characters(number: 10) }
  end
end