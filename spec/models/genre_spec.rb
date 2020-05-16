require 'rails_helper'

RSpec.describe "Genreモデルのテスト", type: :model do
  describe "バリデーションのテスト" do
    context "nameカラム" do
      it "空欄でないこと" do
        genre = build(:genre, name: "")
        genre.valid?
        expect(genre.errors[:name]).to include("を入力してください")
      end

      it "20文字以内であること" do
        genre = build(:genre, name: Faker::Lorem.characters(number:21))
        genre.valid?
        expect(genre.errors[:name]).to include("は20文字以内で入力してください")
      end
    end
  end
end