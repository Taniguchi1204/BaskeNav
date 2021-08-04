class PostPlace < ApplicationRecord
  with_options presence: true do
    validates :post_id
    validates :longitude
    validates :latitude
  end
end
