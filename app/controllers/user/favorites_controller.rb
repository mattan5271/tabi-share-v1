class User::FavoritesController < ApplicationController
  before_action :authenticate_user!

  def index
    user = User.find(params[:user_id])
    @tourist_spots = user.favorite_tourist_spots.page(params[:page]).per(20)
  end

  def create
    @tourist_spot = TouristSpot.find(params[:tourist_spot_id])
    unless @tourist_spot.favorited_by?(current_user)
      favorite = current_user.favorites.new(tourist_spot_id: @tourist_spot.id)
      favorite.save
    end
  end

  def destroy
    @tourist_spot = TouristSpot.find(params[:tourist_spot_id])
    favorite = current_user.favorites.find_by(tourist_spot_id: @tourist_spot.id)
    favorite.destroy
  end
end
