class User::TouristSpotsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
	before_action :set_tourist_spot, only: [:show, :edit, :update, :destroy]

  def new
    @tourist_spot = TouristSpot.new

    @genre_parent_array = ["---"]
    # データベースから、親カテゴリーのみ抽出し、配列化
    Genre.where(ancestry: nil).each do |parent|
      @genre_parent_array << parent.name
    end
  end

  # 親カテゴリーが選択された後に動くアクション
  def get_genre_children
    @genre_children = Genre.find_by(name: params[:parent_name], ancestry: nil).children # 選択された親カテゴリーに紐付く子カテゴリーの配列を取得
  end

  # 子カテゴリーが選択された後に動くアクション
  def get_genre_grandchildren
    @genre_grandchildren = Genre.find(params[:child_id]).children # 選択された子カテゴリーに紐付く孫カテゴリーの配列を取得
  end

  def create
    @tourist_spot = TouristSpot.new(tourist_spot_params)
    @tourist_spot.user_id = current_user.id
		if @tourist_spot.save!
      redirect_to user_tourist_spot_path(@tourist_spot)
    else
			render 'new'
    end

    genre = Genre.find_by(name: params[:grandchild_name])
    tourist_spot_genre = TouristSpotGenre.new
    tourist_spot_genre.tourist_spot_id = @tourist_spot.id
    tourist_spot_genre.genre_id = genre.parent.parent.id
    tourist_spot_genre.save!

    tourist_spot_genre = TouristSpotGenre.new
    tourist_spot_genre.tourist_spot_id = @tourist_spot.id
    tourist_spot_genre.genre_id = genre.parent.id
    tourist_spot_genre.save!

    tourist_spot_genre = TouristSpotGenre.new
    tourist_spot_genre.tourist_spot_id = @tourist_spot.id
    tourist_spot_genre.genre_id = genre.id
    tourist_spot_genre.save!
  end

  def show
    impressionist(@tourist_spot)
  end

  def edit
  end

  def update
		if @tourist_spot.update(tourist_spot_params)
			redirect_to user_tourist_spot_path(@tourist_spot)
    else
			render 'edit'
		end
  end

	def destroy
		@tourist_spot.destroy
		redirect_to user_tourist_spots_path
  end

  # 地図
  def map
    @tourist_spot = TouristSpot.find(params[:tourist_spot_id])
    gon.latitude = @tourist_spot.latitude
    gon.longitude = @tourist_spot.longitude
  end

  # 写真一覧
  def images
    @tourist_spot = TouristSpot.find(params[:tourist_spot_id])
    @reviews = @tourist_spot.reviews
  end

  # キーワード検索
  def keyword_search
    tourist_spots = TouristSpot.keyword_search(params[:keyword_search])
    @keyword_search = params[:keyword_search]
    kaminari = TouristSpot.sort(params[:sort], tourist_spots) # kaminariの仕様上、Arrayから直接ページネーションをする事が出来ないので一旦変数に代入
    @tourist_spots = Kaminari.paginate_array(kaminari).page(params[:page]).per(20)
  end

  # ジャンル検索
  def genre_search
    tourist_spots = TouristSpot.genre_search(params[:genre_search])
    @genre_search = params[:genre_search]
    @genre = Genre.find_by(id: @genre_search)
    kaminari = TouristSpot.sort(params[:sort], tourist_spots) # kaminariの仕様上、Arrayから直接ページネーションをする事が出来ないので一旦変数に代入
    @tourist_spots = Kaminari.paginate_array(kaminari).page(params[:page]).per(20)
  end

  # 利用シーン検索
  def scene_search
    tourist_spots = TouristSpot.scene_search(params[:scene_search])
    @scene_search = params[:scene_search]
    @scene = Scene.find_by(id: @scene_search)
    kaminari = TouristSpot.sort(params[:sort], tourist_spots)# kaminariの仕様上、Arrayから直接ページネーションをする事が出来ないので一旦変数に代入
    @tourist_spots = Kaminari.paginate_array(kaminari).page(params[:page]).per(20)
  end

  # 都道府県検索
  def prefecture_search
    tourist_spots = TouristSpot.prefecture_search(params[:prefecture_search])
    @prefecture_search = params[:prefecture_search]
    @prefecture = JpPrefecture::Prefecture.find(code: @prefecture_search)
    kaminari = TouristSpot.sort(params[:sort], tourist_spots) # kaminariの仕様上、Arrayから直接ページネーションをする事が出来ないので一旦変数に代入
    @tourist_spots = Kaminari.paginate_array(kaminari).page(params[:page]).per(20)
  end

  # タグ検索
  def tag_search
    @tourist_spots = TouristSpot.tagged_with(params[:tag_name]).page(params[:page]).per(20)
    @tags = TouristSpot.tag_counts.order(taggings_count: 'DESC').limit(20)
  end

  # 行きたい！一覧
  def favorites
    @tourist_spots = current_user.favorite_tourist_spots.rank(:row_order).page(params[:page]).per(20)
  end

  # 行った！一覧
  def wents
    @tourist_spots = current_user.went_tourist_spots.rank(:row_order).page(params[:page]).per(20)
  end

  # ドラッグ&ドロップ
  def sort
    tourist_spot = TouristSpot.find(params[:tourist_spot_id])
    tourist_spot.update(tourist_spot_params)
    render body: nil
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
        :tag_list,
        :row_order_position,
        {images: []}
      )
    end
end
