class HomesController < ApplicationController
  def top
    @tourist_spots_rank = TouristSpot.find(Favorite.group(:tourist_spot_id).order('count(tourist_spot_id) desc').limit(3).pluck(:tourist_spot_id))
    gon.tourist_spots = TouristSpot.all
    @genres = Genre.all
    @scenes = Scene.all
  end

  def about
  end
end
