require 'rails_helper'

RSpec.describe 'Messageモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    let(:message) {FactoryBot.build(:message)}

    let(:test_message) { message }
    subject {message.valid?}

    context "user_idカラムのバリデーション" do
      it "空白でないこと" do
        message.user_id = nil
        is_expected.to eq false
      end
    end

    context "room_idカラムのバリデーション" do
      it "空白でないこと" do
        message.room_id = nil
        is_expected.to eq false
      end
    end

    context "messageカラムのバリデーション" do
      it "空白でないこと" do
        message.message = nil
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト'do
    context 'Messageモデルとの関係'do
      it 'userモデルと1:N'do
        expect(Message.reflect_on_association(:user).macro).to eq :belongs_to
      end

      it 'roomモデルと1:N'do
        expect(Message.reflect_on_association(:room).macro).to eq :belongs_to
      end
    end
  end
end