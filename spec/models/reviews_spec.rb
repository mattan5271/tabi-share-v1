require 'rails_helper'

RSpec.describe 'Reviewモデル', type: :model do
  describe 'バリデーション' do
    let(:user) { create(:user) }
    let(:tourist_spot) { create(:tourist_spot, user: user) }
    let(:review) { create(:review, user: user, tourist_spot: tourist_spot) }
    subject { review.valid? }
    it '作成できること' do
      is_expected.to eq true
    end

    context 'images' do
      it '空欄でないこと' do
        review.images = []
        is_expected.to eq false
      end
    end

    context 'title' do
      it '空欄でないこと' do
        review.title = ''
        is_expected.to eq false
      end
      it '50文字以内であること' do
        review.title = Faker::Lorem.characters(number: 51)
        is_expected.to eq false
      end
    end

    context 'body' do
      it '空欄でないこと' do
        review.body = ''
        is_expected.to eq false
      end
      it '200文字以内であること' do
        review.body = Faker::Lorem.characters(number: 201)
        is_expected.to eq false
      end
    end

    context 'score' do
      it '空欄でないこと' do
        review.score = ''
        is_expected.to eq false
      end
    end
  end
end