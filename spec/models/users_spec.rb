require 'rails_helper'

RSpec.describe 'Userモデル', type: :model do
  describe 'バリデーション' do
    let(:user) { create(:user) }
    subject { user.valid? }
    it '作成できること' do
      is_expected.to eq true
    end

    context 'name' do
      it '空欄でないこと' do
        user.name = ''
        is_expected.to eq false
      end
      it '重複していないこと' do
        another_user = build(:user, name: user.name)
        expect(another_user).not_to be_valid
      end
      it "20文字以内であること" do
        user.name = Faker::Lorem.characters(number:21)
        is_expected.to eq false
      end
    end

    context 'sex' do
      it '空欄でないこと' do
        user.sex = ''
        is_expected.to eq false
      end
    end

    context 'age' do
      it '空欄でないこと' do
        user.age = ''
        is_expected.to eq false
      end
    end

    context 'postcode' do
      it '空欄なら正規表現のバリデーションをスルーする' do
        user.postcode = ''
        is_expected.to eq true
      end
      it '正規表現が正しいこと' do
        user.postcode = '111-1111'
        expect(user.postcode).to match(/\A[0-9]{3}-[0-9]{4}\z/)
      end
    end

    context 'address_city' do
      it '50文字以内であること' do
        user.address_city = Faker::Lorem.characters(number:51)
        is_expected.to eq false
      end
    end

    context 'address_street' do
      it '50文字以内であること' do
        user.address_street = Faker::Lorem.characters(number:51)
        is_expected.to eq false
      end
    end

    context 'address_building' do
      it '50文字以内であること' do
        user.address_building = Faker::Lorem.characters(number:51)
        is_expected.to eq false
      end
    end

    context 'introduction' do
      it '50文字以内であること' do
        user.introduction = Faker::Lorem.characters(number:201)
        is_expected.to eq false
      end
    end
  end
end