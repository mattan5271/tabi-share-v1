class Like < ApplicationRecord
  belongs_to :user
  belongs_to :review

  def user_rank_update(review)
    @likes_sum = 0
    review.user.reviews.each do |review|
      @likes_sum += review.likes.count
    end
    case @likes_sum
    when 0..9
      review.user.rank = "レギュラー"
    when 1..49
      review.user.rank = "シルバー"
    when 50..99
      review.user.rank = "ゴールド"
    when 100..299
      review.user.rank = "プラチナ"
    when 300..9999
      review.user.rank = "ダイヤモンド"
    end
    review.user.save
  end
end
