FactoryBot.define do
  factory :user do
    name { Faker::Lorem.characters(number: 10) }
    email { Faker::Internet.email }
    phone_number{ Faker::Number.number(digits: 10)}
    introduce {Faker::Lorem.characters(number: 20)}
    user_image_id {Faker::Lorem.characters(number: 10)}
    password { 'password' }
    password_confirmation { 'password' }
  end
end