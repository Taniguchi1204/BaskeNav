class Post < ApplicationRecord
  with_options presence: true do
    validates :user_id
    validates :content
  end

  belongs_to :user
  has_many   :post_comments,  dependent: :destroy
  has_many   :post_favorites, dependent: :destroy
  has_many   :tags,           dependent: :destroy
  attachment :image

  has_one :post_place, dependent: :destroy
  accepts_nested_attributes_for   :post_place

  # いいねをしている投稿があるか
  def favorites_by?(user)
    post_favorites.where(user_id: user.id).exists?
  end
end