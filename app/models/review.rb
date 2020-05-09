class Review < ApplicationRecord
  belongs_to :user
  belongs_to :tourist_spot

  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy

  mount_uploaders :images, ImageUploader

  enum is_value: { "本名": true, "仮名": false }

  validates :title, presence: true

  # すでにいいねしているかを確認
  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

  # おすすめ順
  def self.recommended_order
    self.find(Like.group(:review_id).order('count(review_id) desc').limit(5).pluck(:review_id))
  end

  # 新着順
  def self.new_order
    self.order(id: 'DESC')
  end

  # コメント数順
  def self.comments_order
    self.find(Comment.group(:review_id).order('count(review_id) desc').pluck(:review_id))
  end

  # 点数順
  def self.score_order
    self.order(score: "DESC")
  end

  #ユーザーのポイントによってランク付け
  def user_rank_update(user)
    case user.point
    when 0..9
      user.rank = "レギュラー"
    when 10..49
      user.rank = "シルバー"
      Coupon.coupon_create(user)
    when 50..99
      user.rank = "ゴールド"
      Coupon.coupon_create(user)
    when 100..299
      user.rank = "プラチナ"
      Coupon.coupon_create(user)
    when 300..9999
      user.rank = "ダイヤモンド"
      Coupon.coupon_create(user)
    end
    user.save
  end

  def create_notification_like!(current_user)
    # すでにいいねされているかを確認
    temp = Notification.where(["visitor_id = ? and visited_id = ? and review_id = ? and action = ? ", current_user.id, user_id, id, 'like'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        review_id: id,
        visited_id: user_id,
        action: 'like'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  def create_notification_comment!(current_user, comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = Comment.select(:user_id).where(review_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      review_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end
