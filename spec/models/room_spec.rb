require 'rails_helper'

RSpec.describe 'Roomモデルのテスト', type: :model do
  describe 'アソシエーションのテスト'do
    context 'Roomモデルとの関係'do
      it 'entriesモデルが1:N'do
        expect(Room.reflect_on_association(:entries).macro).to eq :has_many
      end

      it 'messagesモデルが1:N'do
        expect(Room.reflect_on_association(:messages).macro).to eq :has_many
      end
    end
  end
end