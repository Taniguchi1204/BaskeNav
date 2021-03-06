# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Adminモデルのテスト', type: :model do
  describe 'バリデーションのテスト'do
    let(:admin) {FactoryBot.build(:admin)}
    let(:test_admin){ admin }
    subject { test_admin.valid? }


    context 'nameカラム' do
      it '空白でないこと'do
        admin.name = ''
        is_expected.to eq false
      end

      it '２文字以上であること：１文字は不可'do
        admin.name = Faker::Lorem.characters(number: 1)
        is_expected.to eq false
      end

      it '２文字以上であること：１文字は可'do
        admin.name = Faker::Lorem.characters(number: 2)
        is_expected.to eq true
      end

      it '２０文字以下であること：２０文字は可'do
        admin.name = Faker::Lorem.characters(number: 20)
        is_expected.to eq true
      end

      it '２０文字以下であること：２１文字は不可'do
        admin.name = Faker::Lorem.characters(number: 21)
        is_expected.to eq false
      end
    end

    context 'passwordカラム' do
      it '空白でないこと' do
        admin.password = ''
        is_expected.to eq false
      end

      it '6文字より少なくないこと' do
        admin.password = "a"*5
        admin.password_confirmation = "a"*5
        is_expected.to eq false
      end

      it '6文字以上であれば保存される' do
        admin.password = "a"*6
        admin.password_confirmation = "a"*6
        is_expected.to eq true
      end
    end

    context 'emailカラム' do
      it '空白ではないこと' do
        admin.email = ''
        is_expected.to eq false
      end
      it '有効なメールアドレスであること'do
        admin.email = Faker::Internet.email
        is_expected.to eq true
      end
      it '無効なメールアドレスでないこと'do
        admin.email = Faker::Lorem.characters(number: 20)
        is_expected.to eq false
      end
    end

    context 'phone_numberカラム'do
      it '空白でないこと'do
        admin.phone_number = ''
        is_expected.to eq false
      end

      it '10桁であること' do
        admin.phone_number = Faker::Number.number(digits: 10)
        is_expected.to eq true
      end

      it '11桁であること' do
        admin.phone_number = Faker::Number.number(digits: 11)
        is_expected.to eq true
      end

      it '10桁または11桁以外では保存されない' do
        admin.phone_number = Faker::Number.number(digits: 9)
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト'do
    context 'Adminモデルとの関係'do
      it 'facilitiesモデルが1:N'do
        expect(Admin.reflect_on_association(:facilities).macro).to eq :has_many
      end
    end
  end
end