class Relationship < ApplicationRecord
  with_options presence: true do
    validates :following, class_name: "User"
    validates :followed,  class_name: "User"
  end
end
