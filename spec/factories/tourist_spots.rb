Faker::Config.locale = :ja

FactoryBot.define do
  factory :tourist_spot do
    images { [{ 'dog': { 'name': 'test','pic': 'test.jpg' }, 'status': 200 }] }
    name { Faker::Lorem.characters(number: 10) }
    postcode { Faker::Address.postcode }
    prefecture_code { rand(1..42) }
    address_city { Faker::Address.city }
    address_street { Faker::Address.street_name }
    address_building { Faker::Address.building_number }
    introduction { Faker::Lorem.characters(number: 20) }
    access { Faker::Lorem.characters(number: 20) }
    business_hour { Faker::Lorem.characters(number: 20) }
    home_page { Faker::Internet.url }
    phone_number { '111-1111-1111' }
    parking { Faker::Lorem.characters(number: 20) }
  end
end