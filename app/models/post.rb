class Post < ApplicationRecord
  with_options presence: true do
    validates :user_id
    validates :content
  end
end
