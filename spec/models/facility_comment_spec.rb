require 'rails_helper'

RSpec.describe 'FacilityCommentモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    let(:facility_comment) {FactoryBot.build(:facility_comment)}

    let(:test_facility_comment) { facility_comment }
    subject {test_facility_comment.valid?}

    context "user_idカラムのバリデーション" do
      it "空白でないこと" do
        facility_comment.user_id = nil
        is_expected.to eq false
      end
    end

    context "facility_idカラムのバリデーション" do
      it "空白でないこと" do
        facility_comment.facility_id = nil
        is_expected.to eq false
      end
    end

    context "commentカラムのバリデーション" do
      it "空白でないこと" do
        facility_comment.comment = nil
        is_expected.to eq false
      end
    end

    context "rateカラムのバリデーション" do
      it "空白でないこと" do
        facility_comment.rate = nil
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト'do
    context 'FacilityCommentモデルとの関係'do
      it 'userモデルと1:N'do
        expect(FacilityComment.reflect_on_association(:user).macro).to eq :belongs_to
      end

      it 'facilityモデルと1:N'do
        expect(FacilityComment.reflect_on_association(:facility).macro).to eq :belongs_to
      end
    end
  end
end