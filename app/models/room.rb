class Room < ApplicationRecord
  with_options presence: true do
    validates :user_id
  end
  
  has_many :entries,  dependent: :destroy
  has_many :messages, dependent: :destroy
end
