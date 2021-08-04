class Message < ApplicationRecord
  with_options presence: true do
    validates :user_id
    validates :room_id
    validates :message
  end
end
