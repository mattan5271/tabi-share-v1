class User::TouristSpotsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
	before_action :set_tourist_spot, only: [:show, :edit, :update, :destroy]

  def new
    @tourist_spot = TouristSpot.new
  end

  def create
    @tourist_spot = TouristSpot.new(tourist_spot_params)
    @tourist_spot.user_id = current_user.id
		if @tourist_spot.save
			redirect_to user_tourist_spot_path(@tourist_spot)
    else
			render "new"
		end
  end

  def show
  end

  def edit
  end

  def update
		if @tourist_spot.update(tourist_spot_params)
			redirect_to user_tourist_spot_path(@tourist_spot)
    else
			render "edit"
		end
  end

	def destroy
		@tourist_spot.destroy
		redirect_to user_tourist_spots_path
  end

  def map
    @tourist_spot = TouristSpot.find(params[:tourist_spot_id])
  end

  # キーワード検索
  def keyword_search
    tourist_spots_keyword = TouristSpot.keyword_search(params[:search])
    @search = params[:search]
    if tourist_spots_keyword.present?
      @tourist_spots = TouristSpot.sort(params[:sort], tourist_spots_keyword).page(params[:page]).per(40)
    end
  end

  # ジャンル検索
  def genre_search
    tourist_spots_genre = TouristSpot.genre_search(params[:search])
    @search = params[:search]
    if tourist_spots_genre.present?
      @tourist_spots = TouristSpot.sort(params[:sort], tourist_spots_genre).page(params[:page]).per(40)
    end
  end

  # 利用シーン検索
  def scene_search
    tourist_spots_scene = TouristSpot.scene_search(params[:search])
    @search = params[:search]
    if tourist_spots_scene.present?
      @tourist_spots = TouristSpot.sort(params[:sort], tourist_spots_scene).page(params[:page]).per(40)
    end
  end

  # 都道府県検索
  def prefecture_search
    tourist_spots_prefecture = TouristSpot.prefecture_search(params[:search])
    @search = params[:search]
    if tourist_spots_prefecture.present?
      @tourist_spots = TouristSpot.sort(params[:sort], tourist_spots_prefecture).page(params[:page]).per(40)
    end
  end

  private

    def set_tourist_spot
      @tourist_spot = TouristSpot.find(params[:id])
    end

    def tourist_spot_params
			params.require(:tourist_spot).permit(
        :genre_id,
        :scene_id,
        :name,
        :postcode,
        :prefecture_code,
        :address_city,
        :address_street,
        :address_building,
        :latitude,
        :longitude,
        :introduction,
        :access,
        :phone_number,
        :business_hour,
        :is_parking,
        {images: []}
      )
    end
end
