require 'rails_helper'

RSpec.describe 'SnsCredentialモデルのテスト', type: :model do
  describe 'アソシエーションのテスト'do
    context 'SnsCredentialモデルとの関係'do
      it 'userモデルが1:N'do
        expect(SnsCredential.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end