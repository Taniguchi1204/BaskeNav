# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Userモデルのテスト', type: :model do
  describe 'バリデーションのテスト'do
    let(:user){FactoryBot.build(:user)}
    let(:test_user){ user }
    subject { user.valid? }

    context 'nameカラム' do
      it '空白でないこと'do
        user.name = ''
        is_expected.to eq false
      end

      it '２文字以上であること：１文字は不可'do
        user.name = Faker::Lorem.characters(number: 1)
        is_expected.to eq false
      end

      it '２文字以上であること：１文字は可'do
        user.name = Faker::Lorem.characters(number: 2)
        is_expected.to eq true
      end

      it '２０文字以下であること：２０文字は可'do
        user.name = Faker::Lorem.characters(number: 20)
        is_expected.to eq true
      end

      it '２０文字以下であること：２１文字は不可'do
        user.name = Faker::Lorem.characters(number: 21)
        is_expected.to eq false
      end
    end

    context 'emailカラム' do
      it '空白ではないこと' do
        user.email = ''
        is_expected.to eq false
      end
      it '有効なメールアドレスであること'do
        user.email = Faker::Internet.email
        is_expected.to eq true
      end
      it '無効なメールアドレスでないこと'do
        user.email = Faker::Lorem.characters(number: 20)
        is_expected.to eq false
      end
    end

    context 'phone_numberカラム'do
      it '空白でないこと'do
        user.phone_number = ''
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト'do
    context 'Userモデルとの関係'do
      it 'postsモデルが1:N'do
        expect(User.reflect_on_association(:posts).macro).to eq :has_many
      end

      it 'reverse_of_relationshipsモデルが1:N'do
        expect(User.reflect_on_association(:reverse_of_relationships).macro).to eq :has_many
      end

      it 'followersモデルが1:N'do
        expect(User.reflect_on_association(:followers).macro).to eq :has_many
      end

      it 'relationshipsモデルが1:N'do
        expect(User.reflect_on_association(:relationships).macro).to eq :has_many
      end

      it 'followingsモデルが1:N'do
        expect(User.reflect_on_association(:followings).macro).to eq :has_many
      end

      it 'entriesモデルが1:N'do
        expect(User.reflect_on_association(:entries).macro).to eq :has_many
      end

      it 'messagesモデルが1:N'do
        expect(User.reflect_on_association(:messages).macro).to eq :has_many
      end

      it 'post_favoritesモデルが1:N'do
        expect(User.reflect_on_association(:post_favorites).macro).to eq :has_many
      end

      it 'post_contentsモデルが1:N'do
        expect(User.reflect_on_association(:post_contents).macro).to eq :has_many
      end

      it 'post_commentsモデルが1:N'do
        expect(User.reflect_on_association(:post_comments).macro).to eq :has_many
      end

      it 'facility_favoritesモデルが1:N'do
        expect(User.reflect_on_association(:facility_favorites).macro).to eq :has_many
      end

      it 'post_facilitiesモデルが1:N'do
        expect(User.reflect_on_association(:post_facilities).macro).to eq :has_many
      end

      it 'facility_commentsモデルが1:N'do
        expect(User.reflect_on_association(:facility_comments).macro).to eq :has_many
      end

      it 'reserve_facilitiesモデルが1:N'do
        expect(User.reflect_on_association(:reserve_facilities).macro).to eq :has_many
      end

      it 'sns_credentialsモデルが1:N'do
        expect(User.reflect_on_association(:sns_credentials).macro).to eq :has_many
      end
    end
  end
end