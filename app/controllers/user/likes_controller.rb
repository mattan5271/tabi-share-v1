class User::LikesController < ApplicationController
  def create
    review = Review.find(params[:review_id])
    like = current_user.likes.new(review_id: review.id)
    like.save
    redirect_to user_tourist_spot_reviews_path
  end
  def destroy
    review = Review.find(params[:review_id])
    like = current_user.likes.find_by(review_id: review.id)
    like.destroy
    redirect_to user_tourist_spot_reviews_path
  end
end
