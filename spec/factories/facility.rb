FactoryBot.define do
  factory :facility do
    name { Faker::Lorem.characters(number: 10) }
    opening { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    
    email { Faker::Internet.email }
    phone_number{ FactoryBot::Number.number(10)}
    introduction { Faker::Lorem.characters(number: 20) }
    password { 'password' }
    password_confirmation { 'password' }
  end
end