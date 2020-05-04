class User::RelationshipsController < ApplicationController
  # フォローする
  def follow
    @user = User.find(params[:id])
    unless current_user.following?(@user)
        current_user.follow(params[:id])
    end
  end

  #アンフォローする
  def unfollow
    @user = User.find(params[:id])
    current_user.unfollow(params[:id])
  end
end
