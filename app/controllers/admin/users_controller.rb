class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_user, only: [:show, :edit, :update]

	def index
    @users = User.all.paginate(params)
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
		@user.update(user_params) ? (redirect_to admin_user_path(@user)) : (render 'edit')
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

  # CSVインポート
  def import
    # fileはtmpに自動で一時保存される
    User.import(params[:file])
    redirect_to admin_users_path
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
