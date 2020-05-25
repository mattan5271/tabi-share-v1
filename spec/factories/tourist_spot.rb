FactoryBot.define do
  factory :tourist_spot do
    user_id { 1 }
    genre_id { 1 }
    scene_id { 1 }
    name { 'test' }
    postcode { '111-1111' }
    prefecture_code { 1 }
    address_city { 'test' }
    address_street { 'test' }
    introduction { 'test' }
    access { 'test' }
    business_hour { 'test' }
    phone_number { '111-1111-1111' }
  end
end