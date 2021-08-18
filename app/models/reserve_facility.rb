class ReserveFacility < ApplicationRecord
  with_options presence: true do
    validates :facility_id
    validates :user_id
    validates :start
    validates :finish
    validates :number
  end

  belongs_to :user
  belongs_to :facility
end
