FactoryBot.define do
  factory :reserve_facility do
    start { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    finish {Faker::Time.between(from: DateTime.now - 2, to: DateTime.now - 1) }
    number {5}
    with_friend { "true" }
    confirm { "false" }
    comment {Faker::Lorem.characters(number: 20)}
    association :facility
    association :user
  end
end