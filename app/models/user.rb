class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable, :omniauthable

  has_many :tourist_spots, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_tourist_spots, through: :favorites, source: :tourist_spot
  has_many :wents, dependent: :destroy
  has_many :went_tourist_spots, through: :wents, source: :tourist_spot
  has_many :reviews, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  attachment :profile_image
  attachment :header_image

  enum is_valid: { "有効": true, "退会済": false }
  enum rank: { "レギュラー": 0, "シルバー": 1, "ゴールド": 2, "プラチナ": 3, "ダイヤモンド": 4 }

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

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    unless user
      user = User.create(
        uid:      auth.uid,
        provider: auth.provider,
        email:    auth.info.email,
        name:  auth.info.name,
        password: Devise.friendly_token[0, 20],
        image:  auth.info.image
      )
    end

    user
  end
end
