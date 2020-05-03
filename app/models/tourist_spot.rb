class TouristSpot < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  belongs_to :scene

  mount_uploaders :images, ImageUploader
  has_many :favorites, dependent: :destroy
  has_many :wents, dependent: :destroy
  has_many :reviews, dependent: :destroy

  enum is_parking: { "有": true, "無": false }

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def wented_by?(user)
    wents.where(user_id: user.id).exists?
  end

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

  def geocode_full_address
    self.address_city + self.address_street
  end

  geocoded_by :geocode_full_address
  after_validation :geocode

  def self.keyword_search(search)
    if search
      TouristSpot.where(['name LIKE ? OR introduction LIKE ? OR address_city LIKE ? OR address_street LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%"])
    else
      TouristSpot.all
    end
  end

  def self.genre_search(search)
    if search
      TouristSpot.where(genre_id: search.to_i)
    else
      TouristSpot.all
    end
  end

  def self.scene_search(search)
    if search
      TouristSpot.where(scene_id: search.to_i)
    else
      TouristSpot.all
    end
  end
end