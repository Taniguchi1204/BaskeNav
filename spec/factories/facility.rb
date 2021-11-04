# 再度確認が必要
FactoryBot.define do
  factory :facility do
    name { Faker::Lorem.characters(number: 10) }
    opening { Faker::Time.between(from: DateTime.now - 3, to: DateTime.now - 2) }
    closing {Faker::Time.between(from: DateTime.now - 2, to: DateTime.now) }
    email { Faker::Internet.email }
    station {Faker::Lorem.characters(number: 10)}
    parking {Faker::Lorem.characters(number: 10)}
    postcode {Faker::Number.number(digits: 7)}
    address {Faker::Lorem.characters(number: 10)}
    phone_number{ Faker::Number.number(digits: 10)}
    comment { Faker::Lorem.characters(number: 20) }
    association :admin

  end
end