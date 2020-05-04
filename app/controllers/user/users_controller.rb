class User::UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update]

	def index
		@users = User.all
  end

  def show
    @currentUserEntry = Entry.where(user_id: current_user.id) # ログインしているユーザーを検索
    @userEntry = Entry.where(user_id: @user.id) # メッセージ相手のユーザーを検索
    unless @user.id == current_user.id
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then #room_idが一致するユーザー同士を探す
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

  def edit
  end

	def update
		if @user.update(user_params)
			redirect_to admin_user_path(@user)
		else
			render "edit"
		end
  end

  # 自分がフォローしているユーザー一覧
  def following
    @user = User.find(params[:user_id])
  end

  # 自分をフォローしているユーザー一覧
  def follower
    @user = User.find(params[:user_id])
  end

	private

		def set_user
			@user = User.find(params[:id])
		end

		def user_params
      params.require(:user).permit(
        :name,
        :postcode,
        :prefecture_code,
        :address_city,
        :address_street,
        :address_building,
        :introduction,
        :profile_image_id,
        :header_image_id,
        :point,
        :rank,
        :is_valid
        )
		end
end
