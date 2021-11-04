FactoryBot.define do
  factory :post_place do
    address {Fakker::Lorem.characters(number: 10)}
    longitude {Faker::Number.number(digits: 10)}
    latitude {Faker::Number.number(digits: 10)}
    association :post
  end
end