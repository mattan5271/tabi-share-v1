class User::WentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @tourist_spot = TouristSpot.find(params[:tourist_spot_id])
    unless @tourist_spot.wented_by?(current_user)
      went = current_user.wents.new(tourist_spot_id: @tourist_spot.id)
      went.save
    end
  end

  def destroy
    @tourist_spot = TouristSpot.find(params[:tourist_spot_id])
    if @tourist_spot.wented_by?(current_user)
      went = current_user.wents.find_by(tourist_spot_id: @tourist_spot.id)
      went.destroy
    end
  end
end
