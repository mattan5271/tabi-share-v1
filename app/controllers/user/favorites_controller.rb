class User::FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @tourist_spot = TouristSpot.find(params[:tourist_spot_id])
    unless @tourist_spot.favorited_by?(current_user)
      favorite = current_user.favorites.new(tourist_spot_id: @tourist_spot.id)
      favorite.save
    end
  end

  def destroy
    @tourist_spot = TouristSpot.find(params[:tourist_spot_id])
    if @tourist_spot.favorited_by?(current_user)
      favorite = current_user.favorites.find_by(tourist_spot_id: @tourist_spot.id)
      favorite.destroy
    end
  end
end
