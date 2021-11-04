require 'rails_helper'

RSpec.describe 'PostCommentモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    let(:post_comment) {FactoryBot.build(:post_comment)}

    let(:test_post_comment) { post_comment }
    subject {test_post_comment.valid?}

    context "user_idカラムのバリデーション" do
      it "空白でないこと" do
        post_comment.user_id = nil
        is_expected.to eq false
      end
    end

    context "post_idカラムのバリデーション" do
      it "空白でないこと" do
        post_comment.post_id = nil
        is_expected.to eq false
      end
    end

    context "commentカラムのバリデーション" do
      it "空白でないこと" do
        post_comment.comment = nil
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト'do
    context 'PostCommentモデルとの関係'do
      it 'userモデルと1:N'do
        expect(PostComment.reflect_on_association(:user).macro).to eq :belongs_to
      end

      it 'postモデルと1:N'do
        expect(PostComment.reflect_on_association(:post).macro).to eq :belongs_to
      end
    end
  end
end