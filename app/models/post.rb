class Post < ApplicationRecord
  belongs_to :user,           dependent: :destroy
  has_one    :post_place,     dependent: :destroy
  has_many   :post_comments,  dependent: :destroy
  has_many   :post_favorites, dependent: :destroy


  attachment :image
  accepts_nested_attributes_for :post_place

  def favorites_by?(user)
    post_favorites.where(user_id: user.id).exists?
  end
end