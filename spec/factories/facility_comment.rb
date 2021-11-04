FactoryBot.define do
  factory :facility_comment do
    comment { Faker::Lorem.characters(number: 5) }
    rate { Faker::Number.between(from: 1, to: 5) }
    association :user
    association :facility
  end
end