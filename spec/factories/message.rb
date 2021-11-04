FactoryBot.define do
  factory :message do
    message {Faker::Lorem.characters(number: 10)}
    association :user
    association :room
  end
end