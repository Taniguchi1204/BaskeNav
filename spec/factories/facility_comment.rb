FactoryBot.define do
  factory :facility_comment do
    comment { Faker::Lorem.characters(number: 5) }
    rate { Faker::Lorem.characters(number: 20) }
    user
    facility
  end
end