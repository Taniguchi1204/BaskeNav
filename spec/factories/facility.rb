# 再度確認が必要
FactoryBot.define do
  factory :facility do
    name { Faker::Lorem.characters(number: 10) }
    opening { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    closing {Faker::Time.between(from: DateTime.now - 2, to: DateTime.now - 1) }
    email { Faker::Internet.email }
    station {Faker::Lorem.characters(number: 10)}
    parking {Faker::Lorem.characters(number: 10)}
    postcode {Faker::Number.number(digits: 10)}
    address {Faker::Lorem.characters(number: 10)}
    phone_number{ Faker::Number.number(digits: 10)}
    comment { Faker::Lorem.characters(number: 20) }
    password { 'password' }
    password_confirmation { 'password' }
    association :admin
    association :facility_image
  end
end