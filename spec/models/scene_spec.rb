require 'rails_helper'

RSpec.describe "Sceneモデルのテスト", type: :model do
  describe "バリデーションのテスト" do
    context "nameカラム" do
      it "空欄でないこと" do
        scene = build(:scene, name: "")
        scene.valid?
        expect(scene.errors[:name]).to include("を入力してください")
      end

      it "20文字以内であること" do
        scene = build(:scene, name: Faker::Lorem.characters(number:21))
        scene.valid?
        expect(scene.errors[:name]).to include("は20文字以内で入力してください")
      end
    end
  end
end