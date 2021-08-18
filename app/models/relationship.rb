class Relationship < ApplicationRecord
  validates :following, presence: true
  validates :followed,  presence: true

  belongs_to :following, class_name: "User"
  belongs_to :followed,  class_name: "User"
end
