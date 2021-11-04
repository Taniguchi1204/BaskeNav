require 'rails_helper'

RSpec.describe 'Tagモデルのテスト', type: :model do
  describe 'アソシエーションのテスト'do
    context 'Tagモデルとの関係'do
      it 'postモデルが1:N'do
        expect(Tag.reflect_on_association(:post).macro).to eq :belongs_to
      end
    end
  end
end