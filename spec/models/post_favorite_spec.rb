require 'rails_helper'

RSpec.describe 'PostFavoriteモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    let(:post_favorite) {FactoryBot.build(:post_favorite)}

    let(:test_post_favorite) { post_favorite }
    subject {test_post_favorite.valid?}

    context "user_idカラムのバリデーション" do
      it "空白でないこと" do
        post_favorite.user_id = nil
        is_expected.to eq false
      end
    end

    context "post_idカラムのバリデーション" do
      it "空白でないこと" do
        post_favorite.post_id = nil
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト'do
    context 'PostFavoriteモデルとの関係'do
      it 'userモデルと1:N'do
        expect(PostFavorite.reflect_on_association(:user).macro).to eq :belongs_to
      end

      it 'postモデルと1:N'do
        expect(PostFavorite.reflect_on_association(:post).macro).to eq :belongs_to
      end
    end
  end
end