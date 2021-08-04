class Entry < ApplicationRecord
  with_options presence: true do
    validates :user_id
    validates :room_id
  end
end
