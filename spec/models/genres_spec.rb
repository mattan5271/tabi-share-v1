require 'rails_helper'

RSpec.describe 'Genreモデル', type: :model do
  describe 'バリデーション' do
    let(:genre) { create(:genre) }
    subject { genre.valid? }
    it '作成できること' do
      is_expected.to eq true
    end

    context 'name' do
      it '空欄でないこと' do
        genre.name = ''
        is_expected.to eq false
      end
      it '20文字以内であること' do
        genre.name = Faker::Lorem.characters(number: 21)
        is_expected.to eq false
      end
    end
  end
end