class FacilityComment < ApplicationRecord
  with_options presence: true do
    validates :user_id
    validates :facility_id
    validates :comment
    validates :rate
  end
end
