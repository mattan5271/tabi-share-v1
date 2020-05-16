class User::CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: [:edit, :update, :destroy]

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @review = @comment.review
    if @comment.save
      @review.create_notification_comment!(current_user, @comment.id)
      redirect_to user_tourist_spot_review_path(@review.tourist_spot, @review)
    else
      @comments = @review.comments.order(id: 'desc').page(params[:page]).per(10)
      render '/user/reviews/show'
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    if @comment.update(comment_params)
      redirect_to user_tourist_spot_review_path(@comment.review.tourist_spot, @comment.review)
    else
      render 'edit'
    end
  end

  def destroy
    @review = @comment.review
    @comment.destroy
    redirect_to user_tourist_spot_review_path(@comment.review.tourist_spot, @comment.review)
  end

  private

    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:review_id, :title, :body)
    end
end
