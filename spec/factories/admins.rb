Faker::Config.locale = :ja

FactoryBot.define do
  factory :admin do
    email { 'admin@admin' }
    password { 'adminadmin' }
    password_confirmation { 'adminadmin' }
  end
end