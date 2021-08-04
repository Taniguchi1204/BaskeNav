class FacilityFavorite < ApplicationRecord
  with_options presence: true do
    validates :user_id
    validates :facility_id
  end
end
