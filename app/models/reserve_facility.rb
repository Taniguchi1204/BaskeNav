class ReserveFacility < ApplicationRecord
  with_options presence: true do
    validates :facility_id
    validates :user_id
    validates :date
    validates :start_time
    validates :finish_time
    validates :number
  end
end
