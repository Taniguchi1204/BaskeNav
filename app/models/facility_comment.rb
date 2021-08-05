class FacilityComment < ApplicationRecord
  with_options presence: true do
    validates :user_id
    validates :facility_id
    validates :comment
    validates :rate
  end
  
  belongs_to :user
  belongs_to :facility
end
