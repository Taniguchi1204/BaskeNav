FactoryBot.define do
  factory :admin do
    name { Faker::Lorem.characters(number: 10) }
    email { Faker::Internet.email }
    phone_number{ Faker::Number.number(10)}
    password { 'password' }
    password_confirmation { 'password' }
  end
end