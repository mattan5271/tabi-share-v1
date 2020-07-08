require 'rails_helper'

RSpec.describe 'TouristSpotモデル', type: :model do
  describe 'バリデーション' do
    let(:user) { create(:user) }
    let(:tourist_spot) { create(:tourist_spot, user: user) }
    subject { tourist_spot.valid? }
    it '作成できること' do
      is_expected.to eq true
    end

    context 'images' do
      it '空欄でないこと' do
        tourist_spot.images = []
        is_expected.to eq false
      end
    end

    context 'name' do
      it '空欄でないこと' do
        tourist_spot.name = ''
        is_expected.to eq false
      end
      it '50文字以内であること' do
        tourist_spot.name = Faker::Lorem.characters(number: 51)
        is_expected.to eq false
      end
    end

    context 'postcode' do
      it '空欄でないこと' do
        tourist_spot.postcode = ''
        is_expected.to eq false
      end
      it '正規表現が正しいこと' do
        tourist_spot.postcode = '111-1111'
        expect(user.postcode).to match(/\A[0-9]{3}-[0-9]{4}\z/)
      end
    end

    context 'address_city' do
      it '空欄でないこと' do
        tourist_spot.address_city = ''
        is_expected.to eq false
      end
      it '50文字以内であること' do
        tourist_spot.address_city = Faker::Lorem.characters(number: 51)
        is_expected.to eq false
      end
    end

    context 'address_street' do
      it '空欄でないこと' do
        tourist_spot.address_street = ''
        is_expected.to eq false
      end
      it '50文字以内であること' do
        tourist_spot.address_street = Faker::Lorem.characters(number: 51)
        is_expected.to eq false
      end
    end

    context 'address_building' do
      it '50文字以内であること' do
        tourist_spot.address_building = Faker::Lorem.characters(number: 51)
        is_expected.to eq false
      end
    end

    context 'introduction' do
      it '空欄でないこと' do
        tourist_spot.introduction = ''
        is_expected.to eq false
      end
      it '400文字以内であること' do
        tourist_spot.introduction = Faker::Lorem.characters(number: 401)
        is_expected.to eq false
      end
    end

    context 'access' do
      it '空欄でないこと' do
        tourist_spot.access = ''
        is_expected.to eq false
      end
      it '200文字以内であること' do
        tourist_spot.access = Faker::Lorem.characters(number: 201)
        is_expected.to eq false
      end
    end

    context 'business_hour' do
      it '空欄でないこと' do
        tourist_spot.business_hour = ''
        is_expected.to eq false
      end
      it '100文字以内であること' do
        tourist_spot.business_hour = Faker::Lorem.characters(number: 101)
        is_expected.to eq false
      end
    end

    context 'phone_number' do
      it '空欄でないこと' do
        tourist_spot.phone_number = ''
        is_expected.to eq false
      end
      it '正規表現が正しいこと' do
        tourist_spot.phone_number = '111-1111-1111'
        expect(tourist_spot.phone_number).to match(/\A[0-9]{1,4}-[0-9]{1,4}-[0-9]{4}\z/)
      end
    end

    context 'home_page' do
      it '空欄でないこと' do
        tourist_spot.home_page = ''
        is_expected.to eq false
      end
      it '100文字以内であること' do
        tourist_spot.home_page = Faker::Lorem.characters(number: 101)
        is_expected.to eq false
      end
    end

    context 'parking' do
      it '空欄でないこと' do
        tourist_spot.parking = ''
        is_expected.to eq false
      end
      it '100文字以内であること' do
        tourist_spot.parking = Faker::Lorem.characters(number: 101)
        is_expected.to eq false
      end
    end
  end
end