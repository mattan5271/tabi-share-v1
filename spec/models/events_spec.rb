require 'rails_helper'

RSpec.describe 'Eventモデル', type: :model do
  describe 'バリデーション' do
    let(:user) { create(:user) }
    let(:event) { create(:event, user: user) }
    subject { event.valid? }
    it '作成できること' do
      is_expected.to eq true
    end

    context 'title' do
      it '空欄でないこと' do
        event.title = ''
        is_expected.to eq false
      end
      it '20文字以内であること' do
        event.title = Faker::Lorem.characters(number: 21)
        is_expected.to eq false
      end
    end

    context 'body' do
      it '空欄でないこと' do
        event.body = ''
        is_expected.to eq false
      end
      it '200文字以内であること' do
        event.body = Faker::Lorem.characters(number: 201)
        is_expected.to eq false
      end
    end

    context 'start_date' do
      it '空欄でないこと' do
        event.start_date = ''
        is_expected.to eq false
      end
    end

    context 'end_date' do
      it '空欄でないこと' do
        event.end_date = ''
        is_expected.to eq false
      end
    end
  end
end