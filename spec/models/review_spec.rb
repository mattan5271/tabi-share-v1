require 'rails_helper'

RSpec.describe "Reviewモデルのテスト", type: :model do
  describe "バリデーションのテスト" do
    context "imagesカラム" do
      it "空欄でないこと" do
        review = build(:review, images: "")
        review.valid?
        expect(review.errors[:images]).to include("を入力してください")
      end
    end

    context "titleカラム" do
      it "空欄でないこと" do
        review = build(:review, title: "")
        review.valid?
        expect(review.errors[:title]).to include("を入力してください")
      end

      it "50文字以内であること" do
        review = build(:review, title: Faker::Lorem.characters(number:51))
        review.valid?
        expect(review.errors[:title]).to include("は50文字以内で入力してください")
      end
    end

    context "bodyカラム" do
      it "空欄でないこと" do
        review = build(:review, body: "")
        review.valid?
        expect(review.errors[:body]).to include("を入力してください")
      end

      it "200文字以内であること" do
        review = build(:review, body: Faker::Lorem.characters(number:201))
        review.valid?
        expect(review.errors[:body]).to include("は200文字以内で入力してください")
      end
    end

    context "scoreカラム" do
      it "空欄でないこと" do
        review = build(:review, score: "")
        review.valid?
        expect(review.errors[:score]).to include("を入力してください")
      end
    end
  end
end