class User::UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :destroy]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def show
    @reviews = @user.reviews.page(params[:page]).per(10)
    if user_signed_in?
      @current_entry = Entry.where(user_id: current_user.id) # Entryモデルからログインユーザーのレコードを抽出
      @another_entry = Entry.where(user_id: @user.id) # Entryモデルからメッセージ相手のレコードを抽出
      unless @user.id == current_user.id
        @current_entry.each do |current|
          @another_entry.each do |another|
            if current.room_id == another.room_id # ルームが存在する場合
              @is_room = true
              @room_id = current.room_id
            end
          end
        end
        unless @is_room # ルームが存在しない場合は新規作成
          @room = Room.new
          @entry = Entry.new
        end
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
      upload_file = params[:user][:profile_image]
      profile_image = File.open(upload_file.tempfile)
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
        :profile_image
      )
		end
end
