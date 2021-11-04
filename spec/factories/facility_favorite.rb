FactoryBot.define do
  factory :facility_favorite do
    association :user
    association :facility
  end
end