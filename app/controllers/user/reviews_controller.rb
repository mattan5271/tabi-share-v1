class User::ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]

  def new
    @tourist_spot = TouristSpot.find(params[:tourist_spot_id])
    @review = Review.new
  end

  def create
    review = Review.new(review_params)
    review.user_id = current_user.id
    if review.save
      if current_user.provider.present?
        current_user.point += 1 # 本名でレビューを投稿していれば、ポイントを与える
        review.user_rank_update(current_user) # レビューを投稿したユーザーのランクをアップデート
        review.is_value = "本名" # レビューが本名で投稿された事を定義する
      else
        review.is_value = "仮名" # レビューが仮名で投稿された事を定義する
      end
      review.save
      redirect_to user_tourist_spot_reviews_path(review.tourist_spot, review)
    else
      render 'new'
    end
  end

  def index
    tourist_spot = TouristSpot.find(params[:tourist_spot_id])
    @reviews = tourist_spot.reviews
  end

  def show
    @comment = Comment.new
    @comments = @review.comments
  end

  def edit
  end

  def update
    if @review.update(review_params)
      redirect_to user_tourist_spot_review_path(@review.tourist_spot, @review)
    else
      rendef 'edit'
    end
  end

  def destroy
    @review.destroy
    redirect_to user_tourist_spot_reviews_path(@review.tourist_spot, @review)
  end

  private

    def set_review
      @review = Review.find(params[:id])
    end

    def review_params
      params.require(:review).permit(:tourist_spot_id, :title, :body, :score, :is_value)
    end
end
