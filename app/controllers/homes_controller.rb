class HomesController < ApplicationController
  def top
    @tourist_spots_rank = TouristSpot.top_ranking # ランキング順(行きたい！数)
    @tourist_spots_new = TouristSpot.top_new #新着
    gon.tourist_spots = TouristSpot.all
  end

  def about
  end
end
