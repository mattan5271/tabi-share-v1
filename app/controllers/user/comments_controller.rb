class User::CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :update, :destroy]

  def create
    comment = Comment.new(comment_params)
    comment.user_id = current_user.id
    if comment.save
      redirect_to user_tourist_spot_review_path(comment.review.tourist_spot, comment.review)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to user_tourist_spot_review_path(@comment.review.tourist_spot, @comment.review)
    else
      rendef 'edit'
    end
  end

  def destroy
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
