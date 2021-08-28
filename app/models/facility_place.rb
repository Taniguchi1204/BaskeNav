class FacilityPlace < ApplicationRecord

  belongs_to :facility

  geocoded_by      :address
  after_validation :geocode
end
