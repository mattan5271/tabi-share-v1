require 'rails_helper'

RSpec.describe "Contactモデルのテスト", type: :model do
  describe "バリデーションのテスト" do
    context "nameカラム" do
      it "空欄でないこと" do
        contact = build(:contact, name: "")
        contact.valid?
        expect(contact.errors[:name]).to include("を入力してください")
      end

      it "20文字以内であること" do
        contact = build(:contact, name: Faker::Lorem.characters(number:21))
        contact.valid?
        expect(contact.errors[:name]).to include("は20文字以内で入力してください")
      end
    end

    context "emailカラム" do
      it "空欄でないこと" do
        contact = build(:contact, email: "")
        contact.valid?
        expect(contact.errors[:email]).to include("を入力してください")
      end

      it "30文字以内であること" do
        contact = build(:contact, email: Faker::Lorem.characters(number:31))
        contact.valid?
        expect(contact.errors[:email]).to include("は30文字以内で入力してください")
      end
    end

    context "titleカラム" do
      it "空欄でないこと" do
        contact = build(:contact, title: "")
        contact.valid?
        expect(contact.errors[:title]).to include("を入力してください")
      end

      it "20文字以内であること" do
        contact = build(:contact, title: Faker::Lorem.characters(number:21))
        contact.valid?
        expect(contact.errors[:title]).to include("は20文字以内で入力してください")
      end
    end

    context "bodyカラム" do
      it "空欄でないこと" do
        contact = build(:contact, body: "")
        contact.valid?
        expect(contact.errors[:body]).to include("を入力してください")
      end

      it "200文字以内であること" do
        contact = build(:contact, body: Faker::Lorem.characters(number:201))
        contact.valid?
        expect(contact.errors[:body]).to include("は200文字以内で入力してください")
      end
    end
  end
end