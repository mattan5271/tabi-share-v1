class User::FavoritesController < ApplicationController
  def index
    user = User.find(params[:user_id])
    @tourist_spots = user.favorite_tourist_spots
  end

  def create
    @tourist_spot = TouristSpot.find(params[:tourist_spot_id])
    favorite = current_user.favorites.new(tourist_spot_id: @tourist_spot.id)
    favorite.save
  end

  def destroy
    @tourist_spot = TouristSpot.find(params[:tourist_spot_id])
    favorite = current_user.favorites.find_by(tourist_spot_id: @tourist_spot.id)
    favorite.destroy
  end
end
