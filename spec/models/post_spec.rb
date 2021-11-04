require 'rails_helper'

RSpec.describe 'Postモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    let(:post) {FactoryBot.build(:post)}

    let(:test_post) { post }
    subject {test_post.valid?}

    context "user_idカラムのバリデーション" do
      it "空白でないこと" do
        post.user_id = nil
        is_expected.to eq false
      end
    end

    context "contentカラムのバリデーション" do
      it "空白でないこと" do
        post.content = nil
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト'do
    context 'Postモデルとの関係'do
      it 'userモデルと1:N'do
        expect(Post.reflect_on_association(:user).macro).to eq :belongs_to
      end

      it 'post_commentsモデルと1:N'do
        expect(Post.reflect_on_association(:post_comments).macro).to eq :has_many
      end

      it 'post_favoritesモデルと1:N'do
        expect(Post.reflect_on_association(:post_favorites).macro).to eq :has_many
      end

      it 'tagsモデルと1:N'do
        expect(Post.reflect_on_association(:tags).macro).to eq :has_many
      end

      it 'post_placeモデルと1:1'do
        expect(Post.reflect_on_association(:post_place).macro).to eq :has_one
      end
    end
  end
end