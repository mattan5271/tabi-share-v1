class User::LikesController < ApplicationController
  def create
    review = Review.find(params[:review_id])
    like = current_user.likes.new(review_id: review.id)
    like.save
    review.create_notification_like!(current_user) # いいねしたことを通知
    review.user.point += 1 # いいねしたレビューを投稿したユーザーにポイントを与える
    review.user_rank_update(review.user) # いいねをしたレビューを投稿したユーザーのランクをアップデート
    redirect_to user_tourist_spot_reviews_path
  end

  def destroy
    review = Review.find(params[:review_id])
    like = current_user.likes.find_by(review_id: review.id)
    like.destroy
    like.user_rank_update(review) # いいねを外したレビューを投稿したユーザーのランクをアップデート
    redirect_to user_tourist_spot_reviews_path
  end
end
