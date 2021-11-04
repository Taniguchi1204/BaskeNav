FactoryBot.define do
  factory :relationship do
    association :following, factory: :user
    association :followed,  factory: :user
  end
end