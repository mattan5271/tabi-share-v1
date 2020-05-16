require 'rails_helper'

RSpec.describe "Userモデルのテスト", type: :model do
  describe "バリデーションのテスト" do
    context "nameカラム" do
      it "空欄でないこと" do
        user = build(:user, name: "")
        user.valid?
        expect(user.errors[:name]).to include("を入力してください")
      end

      it "重複しないこと" do
        user = create(:user)
        another_user = build(:user, name: user.name)
        another_user.valid?
        expect(another_user.errors[:name]).to include("はすでに存在します")
      end

      it "20文字以内であること" do
        user = build(:user, name: Faker::Lorem.characters(number:21))
        user.valid?
        expect(user.errors[:name]).to include("は20文字以内で入力してください")
      end
    end

    context "sexカラム" do
      it "空欄でないこと" do
        user = build(:user, sex: "")
        user.valid?
        expect(user.errors[:sex]).to include("を入力してください")
      end
    end

    context "ageカラム" do
      it "空欄でないこと" do
        user = build(:user, age: "")
        user.valid?
        expect(user.errors[:age]).to include("を入力してください")
      end
    end

    context "introductionカラム" do
      it "空欄でないこと" do
        user= build(:user, introduction: Faker::Lorem.characters(number:201))
        user.valid?
        expect(user.errors[:introduction]).to include("は200文字以内で入力してください")
      end
    end

    context "address_cityカラム" do
      it "空欄でないこと" do
        user= build(:user, address_city: Faker::Lorem.characters(number:51))
        user.valid?
        expect(user.errors[:address_city]).to include("は50文字以内で入力してください")
      end
    end

    context "address_streetカラム" do
      it "空欄でないこと" do
        user= build(:user, address_street: Faker::Lorem.characters(number:51))
        user.valid?
        expect(user.errors[:address_street]).to include("は50文字以内で入力してください")
      end
    end

    context "address_buildingカラム" do
      it "空欄でないこと" do
        user= build(:user, address_building: Faker::Lorem.characters(number:51))
        user.valid?
        expect(user.errors[:address_building]).to include("は50文字以内で入力してください")
      end
    end
  end
end