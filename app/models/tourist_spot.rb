class TouristSpot < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  belongs_to :scene

  has_many :tourist_spot_images
  has_many :tourist_spot_likes, dependent: :destroy
  has_many :wents, dependent: :destroy
  has_many :reviews, dependent: :destroy

  enum is_parking: { "有": true, "無": false }

  include JpPrefecture
  jp_prefecture :prefecture_code

  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end

  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end

  def full_address
    "〒" + self.postcode.to_s + " " + prefecture_name + " " + self.address_city + " " + self.address_street + " " + self.address_building
  end
end