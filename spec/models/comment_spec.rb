require 'rails_helper'

RSpec.describe "Commentモデルのテスト", type: :model do
  describe "バリデーションのテスト" do
    context "titleカラム" do
      it "空欄でないこと" do
        comment = build(:comment, title: "")
        comment.valid?
        expect(comment.errors[:title]).to include("を入力してください")
      end

      it "20文字以内であること" do
        comment = build(:comment, title: Faker::Lorem.characters(number:21))
        comment.valid?
        expect(comment.errors[:title]).to include("は20文字以内で入力してください")
      end
    end

    context "bodyカラム" do
      it "空欄でないこと" do
        comment = build(:comment, body: "")
        comment.valid?
        expect(comment.errors[:body]).to include("を入力してください")
      end

      it "100文字以内であること" do
        comment = build(:comment, body: Faker::Lorem.characters(number:101))
        comment.valid?
        expect(comment.errors[:body]).to include("は100文字以内で入力してください")
      end
    end
  end
end