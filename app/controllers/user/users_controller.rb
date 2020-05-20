class User::UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :destroy]
  before_action :set_user, only: [:edit, :update, :destroy]

  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews.page(params[:page]).per(10)
    if user_signed_in?
      @currentUserEntry = Entry.where(user_id: current_user.id) # ログインしているユーザーを検索
      @userEntry = Entry.where(user_id: @user.id) # メッセージ相手のユーザーを検索
      unless @user.id == current_user.id
        @currentUserEntry.each do |cu|
          @userEntry.each do |u|
            if cu.room_id == u.room_id then # room_idが一致するユーザー同士を探す
              @isRoom = true
              @roomId = cu.room_id
            end
          end
        end
        unless @isRoom
          @room = Room.new
          @entry = Entry.new
        end
      end
    end
  end

  def edit
  end

	def update
		if @user.update(user_params)
			redirect_to user_user_path(@user)
		else
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
    @followings = @user.following_user.where.not(id: current_user.id).page(params[:page]).per(40)
  end

  # 自分をフォローしているユーザー一覧
  def follower
    @user = User.find(params[:user_id])
    @followers = @user.follower_user.where.not(id: current_user.id).page(params[:page]).per(40)
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
        :profile_image,
        :point,
        :rank,
        :is_valid
        )
		end
end
