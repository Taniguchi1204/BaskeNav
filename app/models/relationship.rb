class Relationship < ApplicationRecord
  with_options presence: true do
    validates :following
    validates :followed
  end

  belongs_to :following, class_name: "User"
  belongs_to :followed,  class_name: "User"
end
