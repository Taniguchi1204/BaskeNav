class Facility < ApplicationRecord
  with_options presence: true do
    validates :admin_id
    validates :opening
    validates :closing
    validates :station
    validates :parking
    validates :postcode
    validates :address
    validates :phone_number
    validates :email
  end
  
  validates :postcode, format: {with: /\A[0-9]{7}\z/}
  validates :phone_number, format: {with: /\A[0-9]{10,11}\z/}
  attachment facility_image
  
  belongs_to :admin
  
  has_many :facility_favorites, dependent: :destroy
  has_many :facility_comments,  dependent: :destroy
  has_many :facility_places,    dependent: :destroy
  has_many :reserve_facilities, dependent: :destroy
end
