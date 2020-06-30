class User::UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :destroy]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def show
    @reviews = @user.reviews.paginate(params)
    if user_signed_in?
      @room_id = Room.find_by_id(
        Entry.joins(:room)
          .where('user_id = ? or user_id = ?' ,current_user.id, @user.id)
          .group(:room_id)
          .pluck(:room_id)
          .first)
      if @room_id.present?
        @is_room = true
      else
        @room = Room.new
        @entry = Entry.new
      end
    end
  end

  def edit
    unless @user == current_user
      redirect_to root_path
    end
  end

  def update
    if params[:user][:profile_image].present?
      profile_image = File.open(params[:user][:profile_image].tempfile)
      result = Vision.image_analysis(profile_image) # Vision APIで画像分析
    else
      result = true
    end
    if result == true
      @user.update(user_params)
      redirect_to user_user_path(@user)
    elsif result == false
      flash[:notice] = '画像が不適切です'
			render 'edit'
		end
  end

  # 論理削除
  def destroy
    @user.is_valid = '退会済'
    @user.save
    reset_session
    redirect_to root_path
  end

  # 自分がフォローしているユーザー一覧
  def following
    @user = User.find(params[:user_id])
    @followings = @user.following_user.where.not(id: current_user.id).paginate(params)
  end

  # 自分をフォローしているユーザー一覧
  def follower
    @user = User.find(params[:user_id])
    @followers = @user.follower_user.where.not(id: current_user.id).paginate(params)
  end

  # キーワード検索
  def keyword_search
    @users = User.keyword_search(params[:search])
  end

	private

		def set_user
			@user = User.find(params[:id])
		end

		def user_params
      params.require(:user).permit(
        :name,
        :sex,
        :age,
        :email,
        :postcode,
        :prefecture_code,
        :address_city,
        :address_street,
        :address_building,
        :introduction,
        :profile_image
      )
		end
end
