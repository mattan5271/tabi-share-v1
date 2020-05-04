class User < ApplicationRecord
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
  has_many :books, dependent: :destroy
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following_user, through: :follower, source: :followed
  has_many :follower_user, through: :followed, source: :follower
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

  attachment :profile_image
  attachment :header_image

  enum is_valid: { "有効": true, "退会済": false }
  enum rank: { "レギュラー": 0, "シルバー": 1, "ゴールド": 2, "プラチナ": 3, "ダイヤモンド": 4 }

  include JpPrefecture
  jp_prefecture :prefecture_code

  # ユーザーをフォローする
  def follow(user_id)
      follower.create(followed_id: user_id)
  end

  # ユーザーをアンフォローする
  def unfollow(user_id)
      follower.find_by(followed_id: user_id).destroy
  end

  # フォローしているかを確認
  def following?(user)
      following_user.include?(user)
  end

  # 都道府県名
  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end

  # 都道府県名
  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end

  # 住所を結合
  def full_address
    "〒" + self.postcode.to_s + " " + prefecture_name + " " + self.address_city + " " + self.address_street + " " + self.address_building
  end

  # Facebookログイン用
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
