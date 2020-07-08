Faker::Config.locale = :ja

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    sex { '男性' }
    age { rand(0..100) }
    postcode { Faker::Address.postcode }
    prefecture_code { rand(1..42) }
    address_city { Faker::Address.city }
    address_street { Faker::Address.street_name }
    address_building { Faker::Address.building_number }
    introduction { Faker::Lorem.characters(number: 20) }
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
  end
end