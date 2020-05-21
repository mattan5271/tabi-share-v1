class HomesController < ApplicationController
  def top
    @genres = Genre.all
    @scenes = Scene.all
    @tourist_spots_fav = TouristSpot.fav_ranking # 観光スポット「行きたい!」ランキング
    @tourist_spots_pv = TouristSpot.pv_ranking # 観光スポットPVランキング
    @tags = TouristSpot.tag_ranking # タグランキング
    @reviews = Review.ranking
    @users = User.ranking
    gon.tourist_spots = TouristSpot.all
  end

  def about
  end
end
