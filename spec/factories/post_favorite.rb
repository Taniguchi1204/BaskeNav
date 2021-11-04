FactoryBot.define do
  factory :post_favorite do
    association :user
    association :post
  end
end