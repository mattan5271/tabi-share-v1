require 'rails_helper'

RSpec.describe 'Contactモデル', type: :model do
  describe 'バリデーション' do
    let(:contact) { create(:contact) }
    subject { contact.valid? }
    it '作成できること' do
      is_expected.to eq true
    end

    context 'name' do
      it '空欄でないこと' do
        contact.name = ''
        is_expected.to eq false
      end
      it '20文字以内であること' do
        contact.name = Faker::Lorem.characters(number: 21)
        is_expected.to eq false
      end
    end

    context 'email' do
      it '空欄でないこと' do
        contact.email = ''
        is_expected.to eq false
      end
    end

    context 'title' do
      it '空欄でないこと' do
        contact.title = ''
        is_expected.to eq false
      end
      it '20文字以内であること' do
        contact.title = Faker::Lorem.characters(number: 21)
        is_expected.to eq false
      end
    end

    context 'body' do
      it '空欄でないこと' do
        contact.body = ''
        is_expected.to eq false
      end
      it '200文字以内であること' do
        contact.body = Faker::Lorem.characters(number: 201)
        is_expected.to eq false
      end
    end
  end
end