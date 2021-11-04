require 'rails_helper'

RSpec.describe 'ReserveFacilityモデルのテスト', type: :model do
  describe 'バリデーションのテスト'do
    let(:reserve_facility) {FactoryBot.build(:reserve_facility)}
    let(:test_reserve_facility){ reserve_facility }
    subject { test_reserve_facility.valid? }


    context 'facility_idカラム' do
      it '空白でないこと'do
        reserve_facility.facility_id = ''
        is_expected.to eq false
      end
    end

    context 'user_idカラム' do
      it '空白でないこと' do
        reserve_facility.user_id = ''
        is_expected.to eq false
      end
    end

    context 'numberカラム' do
      it '空白ではないこと' do
        reserve_facility.number = ''
        is_expected.to eq false
      end
    end

    context 'startカラム'do
      it '空白でないこと'do
        reserve_facility.start = ''
        is_expected.to eq false
      end
    end

    context 'finishカラム'do
      it '空白でないこと'do
        reserve_facility.finish = ''
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト'do
    context 'ReserveFacilityモデルとの関係'do
      it 'userモデルが1:N'do
        expect(ReserveFacility.reflect_on_association(:user).macro).to eq :belongs_to
      end

      it 'facilityモデルが1:N'do
        expect(ReserveFacility.reflect_on_association(:facility).macro).to eq :belongs_to
      end
    end
  end
end