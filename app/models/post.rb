class Post < ApplicationRecord
  with_options presence: true do
    validates :user_id
    validates :content
  end
  
  belongs_to :user
  
  has_many :post_favorites, dependent: :destroy
  has_many :post_places,    dependent: :destroy
  has_many :post_comments,  dependent: :destroy
end
