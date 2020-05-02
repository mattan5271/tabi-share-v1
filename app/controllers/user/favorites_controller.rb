class User::FavoritesController < ApplicationController
  def index
    @tourist_spots = current_user.favorite_tourist_spots
  end

  def create
    tourist_spot = TouristSpot.find(params[:tourist_spot_id])
    favorite = current_user.favorites.new(tourist_spot_id: tourist_spot.id)
    favorite.save
    redirect_to user_tourist_spots_path
  end

  def destroy
    tourist_spot = TouristSpot.find(params[:tourist_spot_id])
    favorite = current_user.favorites.find_by(tourist_spot_id: tourist_spot.id)
    favorite.destroy
    redirect_to user_tourist_spots_path
  end
end
