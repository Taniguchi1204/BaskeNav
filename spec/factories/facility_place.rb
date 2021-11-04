FactoryBot.define do
  factory :facility_place do
    address {Faker::Lorem.characters(number: 10)}
    longitude {Faker::Number.number(digits: 10)}
    latitude {Faker::Number.number(digits: 10)}
    association :facility
  end
end