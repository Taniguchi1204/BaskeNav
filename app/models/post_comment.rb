class PostComment < ApplicationRecord
  with_options presence: true do
    validates :user_id
    validates :post_id
    validates :comment
  end
  
  belongs_to :user
  belongs_to :post
end
