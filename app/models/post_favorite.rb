class PostFavorite < ApplicationRecord
  with_options presence: true do
    validates :user_id
    validates :post_id
  end
end
