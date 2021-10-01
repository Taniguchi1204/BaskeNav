FactoryBot.define do
 factory :post do
   content {Faker::Lorem.characters(number:10)}
   image_id {Faker::Lorem.characters(number:20)}
   association :user
 end
end