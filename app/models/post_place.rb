class PostPlace < ApplicationRecord
  
  belongs_to :post

  geocoded_by :address
  after_validation :geocode
end