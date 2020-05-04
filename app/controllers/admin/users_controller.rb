class Admin::UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update]

	def index
		@users = User.all
  end

  def show
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
