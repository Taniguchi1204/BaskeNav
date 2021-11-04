require 'rails_helper'

RSpec.describe 'Relationshipモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    let(:relationship) {FactoryBot.build(:relationship)}

    let(:test_relatioship) { relationship }
    subject {test_relatioship.valid?}

    context "followingカラムのバリデーション" do
      it "空白でないこと" do
        relationship.following = nil
        is_expected.to eq false
      end
    end

    context "followedカラムのバリデーション" do
      it "空白でないこと" do
        relationship.followed = nil
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト'do
    context 'Userモデルとの関係'do
      it 'followingモデルと1:N'do
        expect(Relationship.reflect_on_association(:following).macro).to eq :belongs_to
      end

      it 'followedモデルと1:N'do
        expect(Relationship.reflect_on_association(:followed).macro).to eq :belongs_to
      end
    end
  end
end