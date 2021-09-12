# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Userモデルのテスト', type: :model do
  describe 'バリデーションのテスト'do
    subject { admin.valid? }

    let!(:other_admin) {create(:admin) }
    let(:admin) { build(:admin) }

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