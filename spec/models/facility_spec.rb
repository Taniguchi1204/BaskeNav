require 'rails_helper'

RSpec.describe 'Facilityモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    let(:facility) {FactoryBot.build(:facility)}

    let(:test_facility) { facility }
    subject {test_facility.valid?}

    context "nameカラムのバリデーション" do
      it "空白でないこと" do
        facility.name = nil
        is_expected.to eq false
      end
    end

    context "openingカラムのバリデーション" do
      it "空白でないこと" do
        facility.opening = nil
        is_expected.to eq false
      end
    end

    context "closingカラムのバリデーション" do
      it "空白でないこと" do
        facility.closing = nil
        is_expected.to eq false
      end
    end

    context "stationカラムのバリデーション" do
      it "空白でないこと" do
        facility.station = nil
        is_expected.to eq false
      end
    end

    context "parkingカラムのバリデーション" do
      it "空白でないこと" do
        facility.parking = nil
        is_expected.to eq false
      end
    end

    context "postcodeカラムのバリデーション" do
      it "空白でないこと" do
        facility.postcode = nil
        is_expected.to eq false
      end

      it '7桁でない場合は保存されない' do
        facility.postcode = Faker::Number.number(digits: 6)
        is_expected.to eq false
      end

      it '7桁である場合は保存される' do
        facility.postcode = Faker::Number.number(digits: 7)
        is_expected.to eq true
      end
    end

    context "addressカラムのバリデーション" do
      it "空白でないこと" do
        facility.address = nil
        is_expected.to eq false
      end
    end

    context 'phone_numberカラム'do
      it '空白でないこと'do
        facility.phone_number = ''
        is_expected.to eq false
      end

      it '10桁であること' do
        facility.phone_number = Faker::Number.number(digits: 10)
        is_expected.to eq true
      end

      it '１１桁であること' do
        facility.phone_number = Faker::Number.number(digits: 11)
        is_expected.to eq true
      end

      it '10桁または11桁以外では保存されない' do
        facility.phone_number = Faker::Number.number(digits: 9)
        is_expected.to eq false
      end
    end

    context "emailカラムのバリデーション" do
      it "空白でないこと" do
        facility.email = nil
        is_expected.to eq false
      end

      it '有効なメールアドレスであること'do
        facility.email = Faker::Internet.email
        is_expected.to eq true
      end

      it '無効なメールアドレスでないこと'do
        facility.email = Faker::Lorem.characters(number: 20)
        is_expected.to eq false
      end
    end
  end
  
  describe 'アソシエーションのテスト'do
    context 'Facilityモデルとの関係'do
      it 'adminモデルと1:N'do
        expect(Facility.reflect_on_association(:admin).macro).to eq :belongs_to
      end

      it 'facility_favoriteモデルとN:1'do
        expect(Facility.reflect_on_association(:facility_favorites).macro).to eq :has_many
      end
      
      it 'facility_commentモデルとN:1'do
        expect(Facility.reflect_on_association(:facility_comments).macro).to eq :has_many
      end
      
      it 'reserve_facilitiesモデルとN:1'do
        expect(Facility.reflect_on_association(:reserve_facilities).macro).to eq :has_many
      end
      
      it 'facility_placeモデルと1:1'do
        expect(Facility.reflect_on_association(:facility_place).macro).to eq :has_one
      end
    end
  end
end