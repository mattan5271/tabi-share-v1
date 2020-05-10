class TouristSpot < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  belongs_to :scene

  mount_uploaders :images, ImageUploader
  has_many :favorites, dependent: :destroy
  has_many :wents, dependent: :destroy
  has_many :reviews, dependent: :destroy

  enum is_parking: { "有": true, "無": false }

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
    "〒" + self.postcode.to_s + " " + prefecture_name + " " + self.address_city + " " + self.address_street + " " + self.address_building
  end

  #住所自動入力
  include JpPrefecture
  jp_prefecture :prefecture_code

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

  #キーワード検索
  def self.keyword_search(search)
    if search.present?
      TouristSpot.where(['name LIKE ? OR introduction LIKE ? OR address_city LIKE ? OR address_street LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%"])
    end
  end

  # ジャンル検索
  def self.genre_search(search)
    if search.present?
      TouristSpot.where(genre_id: search.to_i)
    end
  end

  # 利用シーン検索
  def self.scene_search(search)
    if search.present?
      TouristSpot.where(scene_id: search.to_i)
    end
  end

  # 都道府県検索
  def self.prefecture_search(search)
    if search.present?
      TouristSpot.where(prefecture_code: search.to_i)
    end
  end

  # ランキング(行きたい！数)
  def self.top_ranking
    self.where(id: Favorite.group(:tourist_spot_id).order('count(tourist_spot_id) desc').limit(4).pluck(:tourist_spot_id))
  end

  # 新着
  def self.top_new
    self.order(:created_time).limit(4)
  end

  # おすすめ順
  def self.recommended_order
    self.where(id: Favorite.group(:tourist_spot_id).order('count(tourist_spot_id) desc').pluck(:tourist_spot_id))
  end

  # 新着順
  def self.new_order
    self.order(id: 'DESC')
  end

  # レビュー数順
  def self.reviews_order
    self.where(id: Review.group(:tourist_spot_id).order('count(tourist_spot_id) desc').pluck(:tourist_spot_id))
  end

  # 点数順
  def self.score_order
    self.where(id: Review.group(:tourist_spot_id).order('avg(score) desc').pluck(:tourist_spot_id))
  end

  # ランダム表示
  def self.random_order
    self.order("RANDOM()").limit(1)
  end

  # 並び替え
  def self.sort(sort, tourist_spots)
    case sort
    when "1"
      tourist_spots.recommended_order #おすすめ順
    when "2"
      tourist_spots.new_order #新着順
    when "3"
      tourist_spots.reviews_order #レビュー数順
    when "4"
      tourist_spots.score_order #点数順
    when "5"
      tourist_spots.random_order #ランダム表示
    else
      tourist_spots
    end
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
end