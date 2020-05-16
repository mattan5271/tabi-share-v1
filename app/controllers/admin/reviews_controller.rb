class Admin::ReviewsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_review, only: [:show, :edit, :update, :destroy]

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
      redirect_to admin_tourist_spot_review_path(@review.tourist_spot, @review)
    else
      render 'edit'
    end
  end

  def destroy
    @review.destroy
    redirect_to admin_tourist_spot_reviews_path(@review.tourist_spot, @review)
  end

  private

    def set_review
      @review = Review.find(params[:id])
    end

    def review_params
      params.require(:review).permit(:tourist_spot, :title, :body, :score, {images: []})
    end
end
