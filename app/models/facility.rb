class Facility < ApplicationRecord
  with_options presence: true do
    validates :admin_id
    validates :name
    validates :opening
    validates :closing
    validates :station
    validates :parking
    validates :postcode
    validates :address
    validates :phone_number
    validates :email
  end

  validates  :postcode, format: {with: /\A[0-9]{7}\z/, message: "は7桁で記入してください" }
  validates  :phone_number, format: {with: /\A[0-9]{10,11}\z/, message: "は10桁もしくは11桁で記入してください" }
  attachment :facility_image

  belongs_to :admin

  has_many :facility_favorites, dependent: :destroy
  has_many :facility_comments,  dependent: :destroy
  has_many :reserve_facilities, dependent: :destroy

  has_one  :facility_place,     dependent: :destroy
  accepts_nested_attributes_for            :facility_place

  def favorites_by?(user)
    facility_favorites.where(user_id: user.id).exists?
  end
end
