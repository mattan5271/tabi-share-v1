class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_comment, only: [:edit, :update, :destroy]

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to admin_tourist_spot_review_path(@comment.review.tourist_spot, @comment.review)
    else
      rendef 'edit'
    end
  end

  def destroy
    @comment.destroy
    redirect_to admin_tourist_spot_review_path(@comment.review.tourist_spot, @comment.review)
  end

  private

    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:review_id, :title, :body)
    end
end
