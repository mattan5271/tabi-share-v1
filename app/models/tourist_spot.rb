class TouristSpot < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  belongs_to :scene

  has_many :favorites, dependent: :destroy
  has_many :wents, dependent: :destroy
  has_many :reviews, dependent: :destroy

  validates :images, presence: true
  validates :name, presence: true, length: { maximum: 50 }
  validates :genre_id, presence: true
  validates :scene_id, presence: true
  validates :postcode, presence: true, format: {with: /\A[0-9]{3}-[0-9]{4}\z/}
  validates :prefecture_code, presence: true
  validates :address_city, presence: true, length: { maximum: 50 }
  validates :address_street, presence: true, length: { maximum: 50 }
  validates :address_building, length: { maximum: 50 }
  validates :introduction, presence: true, length: { maximum: 200 }
  validates :access, presence: true, length: { maximum: 200 }
  validates :business_hour, presence: true, length: { maximum: 100 }
  validates :phone_number, presence: true, uniqueness: true, format: { with: /\A[0-9]{1,4}-[0-9]{1,4}-[0-9]{4}\z/ }

  enum is_parking: { '有': true, '無': false }

  mount_uploaders :images, ImageUploader # Carrierwave画像アップロード

  acts_as_taggable # タグ付け

  is_impressionable # PV数取得

  #住所自動入力
  include JpPrefecture
  jp_prefecture :prefecture_code

  # ドラッグ&ドロップ時の並び順を管理
  include RankedModel
  ranks :row_order


  # 「行きたい！」に追加しているかを確認
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  # 「行った！」に追加しているかを確認
  def wented_by?(user)
    wents.where(user_id: user.id).exists?
  end

  # 住所を結合
  def full_address
    '〒' + self.postcode.to_s + ' ' + prefecture_name + ' ' + self.address_city + ' ' + self.address_street + ' ' + self.address_building
  end

  # 都道府県名
  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end

  # 都道府県名
  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end

  # 緯度経度を取得
  geocoded_by :geocode_full_address
  after_validation :geocode

  # geocoder用の住所
  def geocode_full_address
    self.address_city + self.address_street
  end

  # レビューの平均点
  def average_score
    @sum = 0
    reviews.each do |review|
      @sum += review.score
    end
    if @sum > 0
      @sum /= reviews.length
    end
    return @sum
  end

  #キーワード検索
  def self.keyword_search(search)
    TouristSpot.where(['name LIKE ? OR introduction LIKE ? OR address_city LIKE ? OR address_street LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%"])
  end

  # ジャンル検索
  def self.genre_search(search)
    TouristSpot.where(genre_id: search.to_i)
  end

  # 利用シーン検索
  def self.scene_search(scene_search)
    TouristSpot.where(scene_id: scene_search.to_i)
  end

  # 都道府県検索
  def self.prefecture_search(search)
    TouristSpot.where(prefecture_code: search.to_i)
  end

  # ランキング(行きたい！数)
  def self.ranking
    self.find(Favorite.group(:tourist_spot_id).order('count(tourist_spot_id) desc').limit(10).pluck(:tourist_spot_id))
  end

  # 並び替え
  def self.sort(sort, tourist_spots)
    if tourist_spots.present?
      case sort
      when "1"
        # おすすめ順
        tourist_spots.find(Went.group(:tourist_spot_id).order('count(tourist_spot_id) DESC').pluck(:tourist_spot_id))
      when "2"
        # 新着順
        tourist_spots.order(id: 'DESC')
      when "3"
        # レビュー数順
        tourist_spots.find(Review.group(:tourist_spot_id).order('count(tourist_spot_id) DESC').pluck(:tourist_spot_id))
      when "4"
        # 点数順
        tourist_spots.find(Review.group(:tourist_spot_id).order('avg(score) DESC').pluck(:tourist_spot_id))
      when "5"
        # ランダム表示
        tourist_spots.order('RANDOM()').limit(1)
      else
        tourist_spots
      end
    else
      # kaminariのエラー対策で空の配列を代入
      tourist_spots = []
    end
  end
end