Faker::Config.locale = :ja

FactoryBot.define do
  factory :review do
    images { [{ 'dog': { 'name': 'test','pic': 'test.jpg' }, 'status': 200 }] }
    title { Faker::Lorem.characters(number: 10) }
    body { Faker::Lorem.characters(number: 10) }
    score { rand(0..100) }
  end
end