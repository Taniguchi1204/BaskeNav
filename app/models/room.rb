class Room < ApplicationRecord
  with_options presence: true do
    validates :user_id
  end
end
