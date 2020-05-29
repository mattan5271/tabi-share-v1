class User::ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_review, only: [:show, :edit, :update, :destroy]

  def new
    @review = Review.new
  end

  def create
    tourist_spot = TouristSpot.find(params[:tourist_spot_id])
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    @review.tourist_spot_id = tourist_spot.id
    if @review.save
      if @review.user.provider.present?
        @review.user.point += 1 # 本名でレビューを投稿していれば、ポイントを与える
        @review.user_rank_update(@review.user) # レビューを投稿したユーザーのランクをアップデート
        @review.is_value = '本名' # レビューが本名で投稿された事を定義する
      else
        @review.is_value = '仮名' # レビューが仮名で投稿された事を定義する
      end
      @review.save
      redirect_to user_tourist_spot_reviews_path(@review.tourist_spot, @review)
    else
      render 'new'
    end
  end

  def index
    @tourist_spot = TouristSpot.find(params[:tourist_spot_id])
    kaminari = Review.sort(params[:sort], @tourist_spot.reviews)
    @reviews = Kaminari.paginate_array(kaminari).page(params[:page]).per(20)
  end

  def show
    @comment = Comment.new
    @comments = @review.comments.order(id: 'DESC').page(params[:page]).per(10)
  end

  def edit
    unless @review.user == current_user
      redirect_to root_path
    end
  end

  def update
    if @review.update(review_params)
      redirect_to user_tourist_spot_review_path(@review.tourist_spot, @review)
    else
      render 'edit'
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
      params.require(:review).permit(:tourist_spot, :title, :body, :score, { images: [] })
    end
end
