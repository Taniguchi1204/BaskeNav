require 'rails_helper'

RSpec.describe 'Entryモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    let(:entry) {FactoryBot.build(:entry)}

    let(:test_entry) { entry }
    subject {test_entry.valid?}

    context "user_idカラムのバリデーション" do
      it "空白でないこと" do
        entry.user_id = nil
        is_expected.to eq false
      end
    end

    context 'room_idカラムのバリデーション' do
      it "空白でないこと" do
        entry.room_id = nil
        is_expected.to eq false
      end
    end
  end
  
  describe 'アソシエーションのテスト' do
    context 'Entryモデルとの関係' do
      it 'userモデルと1:N' do
        expect(Entry.reflect_on_association(:user).macro).to eq :belongs_to
      end
      
      it 'roomモデルと1:N' do
        expect(Entry.reflect_on_association(:room).macro).to eq :belongs_to
      end
    end
  end
end