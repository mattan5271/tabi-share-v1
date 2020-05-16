require 'rails_helper'

RSpec.describe "TouristSpotモデルのテスト", type: :model do
  describe "バリデーションのテスト" do
    context "genre_idカラム" do
      it "空欄でないこと" do
        tourist_spot = build(:tourist_spot, genre_id: "")
        tourist_spot.valid?
        expect(tourist_spot.errors[:genre_id]).to include("を入力してください")
      end
    end

    context "scene_idカラム" do
      it "空欄でないこと" do
        tourist_spot = build(:tourist_spot, scene_id: "")
        tourist_spot.valid?
        expect(tourist_spot.errors[:scene_id]).to include("を入力してください")
      end
    end

    context "nameカラム" do
      it "空欄でないこと" do
        tourist_spot = build(:tourist_spot, name: "")
        tourist_spot.valid?
        expect(tourist_spot.errors[:name]).to include("を入力してください")
      end

      # it "重複しないこと" do
      #   tourist_spot = build(:tourist_spot)
      #   tourist_spot.save!
      #   another_tourist_spot = build(:tourist_spot, name: tourist_spot.name)
      #   another_tourist_spot.valid?
      #   expect(another_tourist_spot.errors[:name]).to include("はすでに存在します")
      # end

      it "50文字以内であること" do
        tourist_spot = build(:tourist_spot, name: Faker::Lorem.characters(number:51))
        tourist_spot.valid?
        expect(tourist_spot.errors[:name]).to include("は50文字以内で入力してください")
      end
    end

    context "imagesカラム" do
      it "空欄でないこと" do
        tourist_spot = build(:tourist_spot, images: "")
        tourist_spot.valid?
        expect(tourist_spot.errors[:images]).to include("を入力してください")
      end
    end

    context "postcodeカラム" do
      it "空欄でないこと" do
        tourist_spot = build(:tourist_spot, postcode: "")
        tourist_spot.valid?
        expect(tourist_spot.errors[:postcode]).to include("を入力してください")
      end
    end

    context "prefecture_codeカラム" do
      it "空欄でないこと" do
        tourist_spot = build(:tourist_spot, prefecture_code: "")
        tourist_spot.valid?
        expect(tourist_spot.errors[:prefecture_code]).to include("を入力してください")
      end
    end

    context "address_cityカラム" do
      it "空欄でないこと" do
        tourist_spot = build(:tourist_spot, address_city: "")
        tourist_spot.valid?
        expect(tourist_spot.errors[:address_city]).to include("を入力してください")
      end

      it "50文字以内であること" do
        tourist_spot = build(:tourist_spot, address_city: Faker::Lorem.characters(number:51))
        tourist_spot.valid?
        expect(tourist_spot.errors[:address_city]).to include("は50文字以内で入力してください")
      end
    end

    context "address_streetカラム" do
      it "空欄でないこと" do
        tourist_spot = build(:tourist_spot, address_street: "")
        tourist_spot.valid?
        expect(tourist_spot.errors[:address_street]).to include("を入力してください")
      end

      it "50文字以内であること" do
        tourist_spot = build(:tourist_spot, address_street: Faker::Lorem.characters(number:51))
        tourist_spot.valid?
        expect(tourist_spot.errors[:address_street]).to include("は50文字以内で入力してください")
      end
    end

    context "address_buildingカラム" do
      it "50文字以内であること" do
        tourist_spot = build(:tourist_spot, address_building: Faker::Lorem.characters(number:51))
        tourist_spot.valid?
        expect(tourist_spot.errors[:address_building]).to include("は50文字以内で入力してください")
      end
    end

    context "introductionカラム" do
      it "空欄でないこと" do
        tourist_spot = build(:tourist_spot, introduction: "")
        tourist_spot.valid?
        expect(tourist_spot.errors[:introduction]).to include("を入力してください")
      end

      it "200文字以内であること" do
        tourist_spot = build(:tourist_spot, introduction: Faker::Lorem.characters(number:201))
        tourist_spot.valid?
        expect(tourist_spot.errors[:introduction]).to include("は200文字以内で入力してください")
      end
    end

    context "accessカラム" do
      it "空欄でないこと" do
        tourist_spot = build(:tourist_spot, access: "")
        tourist_spot.valid?
        expect(tourist_spot.errors[:access]).to include("を入力してください")
      end

      it "200文字以内であること" do
        tourist_spot = build(:tourist_spot, access: Faker::Lorem.characters(number:201))
        tourist_spot.valid?
        expect(tourist_spot.errors[:access]).to include("は200文字以内で入力してください")
      end
    end

    context "business_hourカラム" do
      it "空欄でないこと" do
        tourist_spot = build(:tourist_spot, business_hour: "")
        tourist_spot.valid?
        expect(tourist_spot.errors[:business_hour]).to include("を入力してください")
      end

      it "100文字以内であること" do
        tourist_spot = build(:tourist_spot, business_hour: Faker::Lorem.characters(number:101))
        tourist_spot.valid?
        expect(tourist_spot.errors[:business_hour]).to include("は100文字以内で入力してください")
      end
    end

    context "phone_numberカラム" do
      it "空欄でないこと" do
        tourist_spot = build(:tourist_spot, phone_number: "")
        tourist_spot.valid?
        expect(tourist_spot.errors[:phone_number]).to include("を入力してください")
      end
    end
  end
end