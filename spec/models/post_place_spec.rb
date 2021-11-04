require 'rails_helper'

RSpec.describe 'PostPlaceモデルのテスト', type: :model do
  describe 'アソシエーションのテスト'do
    context 'PostFavoriteモデルとの関係'do
      it 'postモデルと1:N'do
        expect(PostPlace.reflect_on_association(:post).macro).to eq :belongs_to
      end
    end
  end
end