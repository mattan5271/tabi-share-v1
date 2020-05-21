require 'csv' # CSVエクスポート

class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
	before_action :set_user, only: [:show, :edit, :update]

	def index
    @users = User.all.order(created_at: 'DESC').page(params[:page]).per(20)
    respond_to do |format|
      format.html
      format.csv do |csv|
        send_users_csv(@users)
      end
    end
  end

  def show
  end

  def edit
  end

	def update
		if @user.update(user_params)
			redirect_to admin_user_path(@user)
		else
			render 'edit'
		end
  end

  # CSVエクスポート
  def send_users_csv(users)
    csv_data = CSV.generate do |csv|
      header = %w(ID 登録日 氏名 性別 年齢 メールアドレス)
      csv << header

      users.each do |user|
        values = [user.id, user.created_at.to_s(:datetime_jp), user.name, user.sex, user.age, user.email]
        csv << values
      end

    end
    send_data(csv_data, filename: 'ユーザー一覧情報')
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
        :introduction, :profile_image_id,
        :header_image_id,
        :point,
        :rank,
        :is_valid
        )
		end
end
