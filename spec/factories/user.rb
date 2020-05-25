FactoryBot.define do
  factory :user do
    email { 'test@test.test' }
    password { 'testtest' }
    name { 'test' }
    sex { '男性' }
    age { 20 }
  end
end