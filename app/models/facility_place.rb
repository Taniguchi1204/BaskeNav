class FacilityPlace < ApplicationRecord
  with_options presence: true do
    validates :facility_id
    validates :longitude
    validates :latitude
  end
end
