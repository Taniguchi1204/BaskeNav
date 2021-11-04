FactoryBot.define do
  factory :sns_credential do
    provider {Faker::Lorem.characters(number: 10)}
    uid {Faker::Lorem.characters(number:10)}
    association :user
  end
end