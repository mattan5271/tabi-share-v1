class User::ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]

  def new
    @review = Review.new
  end

  def create
    tourist_spot = TouristSpot.find(params[:tourist_spot_id])
    review = Review.new(review_params)
    review.user_id = current_user.id
    review.tourist_spot_id = tourist_spot.id
    review
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
    case params[:sort]
    when "1"
      @reviews = Review.recommended_order #おすすめ順
    when "2"
      @reviews = Review.new_order #新着順
    when "3"
      @reviews = Review.comments_order #コメント数順
    when "4"
      p "成功"
      @reviews = Review.score_order #点数順
    else
      @reviews = Review.all
    end
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
      params.require(:review).permit(:tourist_spot, :title, :body, :score, {images: []})
    end
end
