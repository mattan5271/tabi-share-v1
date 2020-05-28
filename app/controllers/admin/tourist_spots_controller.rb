class Admin::TouristSpotsController < ApplicationController
  before_action :authenticate_admin!
	before_action :set_tourist_spot, only: [:show, :edit, :update, :destroy]

  def index
    @tourist_spots = TouristSpot.all.page(params[:page]).per(20)
  end

  def show
  end

  def edit
    @genre_parent_array = Genre.genre_parent_array_create
  end

  def update
    if @tourist_spot.update(tourist_spot_params)
      tourist_spot_genres = TouristSpotGenre.where(tourist_spot_id: @tourist_spot.id)
      tourist_spot_genres.destroy_all # ジャンル(中間テーブルのレコード)を一旦全削除
      TouristSpotGenre.maltilevel_genre_create(
        @tourist_spot,
        params[:parent_id],
        params[:children_id],
        params[:grandchildren_id]
      )
      redirect_to admin_tourist_spot_path(@tourist_spot)
    else
      @genre_parent_array = Genre.genre_parent_array_create
			render 'edit'
		end
  end

	def destroy
		@tourist_spot.destroy
		redirect_to admin_tourist_spots_path
  end

  private

    def set_tourist_spot
      @tourist_spot = TouristSpot.find(params[:id])
    end

    def tourist_spot_params
			params.require(:tourist_spot).permit(
        :name,
        :postcode,
        :prefecture_code,
        :address_city,
        :address_street,
        :address_building,
        :introduction,
        :access,
        :phone_number,
        :business_hour,
        :home_page,
        :parking,
        :tag_list,
        {images: []},
        { scene_ids: [] }
      )
    end
end
