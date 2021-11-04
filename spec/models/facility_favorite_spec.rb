require 'rails_helper'

RSpec.describe 'FacilityFavoriteモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    let(:facility_favorite) {FactoryBot.build(:facility_favorite)}

    let(:test_facility_favorite) { facility_favorite }
    subject {test_facility_favorite.valid?}

    context "user_idカラムのバリデーション" do
      it "空白でないこと" do
        facility_favorite.user_id = nil
        is_expected.to eq false
      end
    end

    context "facility_idカラムのバリデーション" do
      it "空白でないこと" do
        facility_favorite.facility_id = nil
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト'do
    context 'FacilityFavoriteモデルとの関係'do
      it 'userモデルと1:N'do
        expect(FacilityFavorite.reflect_on_association(:user).macro).to eq :belongs_to
      end

      it 'facilityモデルと1:N'do
        expect(FacilityFavorite.reflect_on_association(:facility).macro).to eq :belongs_to
      end
    end
  end
end