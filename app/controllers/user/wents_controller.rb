class User::WentsController < ApplicationController
  def index
    user = User.find(params[:user_id])
    @tourist_spots = user.went_tourist_spots
  end

  def create
    @tourist_spot = TouristSpot.find(params[:tourist_spot_id])
    went = current_user.wents.new(tourist_spot_id: @tourist_spot.id)
    went.save
  end

  def destroy
    @tourist_spot = TouristSpot.find(params[:tourist_spot_id])
    went = current_user.wents.find_by(tourist_spot_id: @tourist_spot.id)
    went.destroy
  end
end
