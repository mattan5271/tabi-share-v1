require 'rails_helper'

RSpec.describe 'Commentモデル', type: :model do
  describe 'バリデーション' do
    let(:user) { create(:user) }
    let(:tourist_spot) { create(:tourist_spot, user: user) }
    let(:review) { create(:review, user: user, tourist_spot: tourist_spot) }
    let(:comment) { create(:comment, user: user, review: review) }
    subject { comment.valid? }
    it '作成できること' do
      is_expected.to eq true
    end

    context 'title' do
      it '空欄でないこと' do
        comment.title = ''
        is_expected.to eq false
      end
      it '20文字以内であること' do
        comment.title = Faker::Lorem.characters(number: 21)
        is_expected.to eq false
      end
    end

    context 'body' do
      it '空欄でないこと' do
        comment.body = ''
        is_expected.to eq false
      end
      it '100文字以内であること' do
        comment.body = Faker::Lorem.characters(number: 101)
        is_expected.to eq false
      end
    end
  end
end