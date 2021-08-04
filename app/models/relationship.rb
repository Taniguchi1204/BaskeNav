class Relationship < ApplicationRecord
  with_options presence: true do
    validates :following_id
    validates :follower_id
  end
end
