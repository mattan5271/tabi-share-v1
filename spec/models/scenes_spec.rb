require 'rails_helper'

RSpec.describe 'Sceneモデル', type: :model do
  describe 'バリデーション' do
    let(:scene) { create(:scene) }
    subject { scene.valid? }
    it '作成できること' do
      is_expected.to eq true
    end

    context 'name' do
      it '空欄でないこと' do
        scene.name = ''
        is_expected.to eq false
      end
      it '20文字以内であること' do
        scene.name = Faker::Lorem.characters(number: 21)
        is_expected.to eq false
      end
    end
  end
end