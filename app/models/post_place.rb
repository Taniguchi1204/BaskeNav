class PostPlace < ApplicationRecord
  with_options presence: true do
    validates :post_id
    validates :longitude
    validates :latitude
  end

  belongs_to :post

  geocoded_by      :address
  after_validation :geocode
end
