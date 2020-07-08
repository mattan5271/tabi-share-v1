require 'rails_helper'

RSpec.describe 'Messageモデル', type: :model do
  describe 'バリデーション' do
    let(:user) { create(:user) }
    let(:room) { create(:room) }
    let(:message) { create(:message, user: user, room: room) }
    subject { message.valid? }
    it '作成できること' do
      is_expected.to eq true
    end

    context 'body' do
      it '空欄でないこと' do
        message.body = ''
        is_expected.to eq false
      end
      it '200文字以内であること' do
        message.body = Faker::Lorem.characters(number: 201)
        is_expected.to eq false
      end
    end
  end
end