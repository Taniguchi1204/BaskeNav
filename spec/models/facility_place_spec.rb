require 'rails_helper'

RSpec.describe 'FacilityPlaceモデルのテスト', type: :model do
  describe 'アソシエーションのテスト'do
    context 'FacilityFavoriteモデルとの関係'do
      it 'facilityモデルと1:N'do
        expect(FacilityPlace.reflect_on_association(:facility).macro).to eq :belongs_to
      end
    end
  end
end