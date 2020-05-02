class User::WentsController < ApplicationController
  def index
    @tourist_spots = current_user.went_tourist_spots
  end

  def create
    tourist_spot = TouristSpot.find(params[:tourist_spot_id])
    went = current_user.wents.new(tourist_spot_id: tourist_spot.id)
    went.save
    redirect_to user_tourist_spots_path
  end

  def destroy
    tourist_spot = TouristSpot.find(params[:tourist_spot_id])
    went = current_user.wents.find_by(tourist_spot_id: tourist_spot.id)
    went.destroy
    redirect_to user_tourist_spots_path
  end
end
